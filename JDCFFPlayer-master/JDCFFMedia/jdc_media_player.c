//
//  jdc_media_player.c
//  JDCFFPlayer
//
//  Created by Jidong Chen on 01/04/2017.
//  Copyright © 2017 jidong. All rights reserved.
//

#include "jdc_media_player.h"
#include "jdc_video_frame.h"
#include "time.h"

#define FF_QUIT_EVENT 10086
#define FF_REFRESH_EVENT 10087

#define AV_SYNC_THRESHOLD 0.01
#define AV_NOSYNC_THRESHOLD 10.0

int jdc_media_init()
{
    av_register_all();
    return 0;
}

double synchronize_video(JDCMediaContext *mCtx , AVFrame *frame , double pst)
{
    double frame_delay = 0;
    if (pst != 0) {
        mCtx->videoClock = pst;
    }else{
        pst = mCtx->videoClock;
    }
    
    frame_delay = av_q2d(mCtx->videoStream->time_base);
    frame_delay += frame->repeat_pict * (frame_delay * 0.5);
    mCtx->videoClock += frame_delay;
    
    return pst;
}

// 1.从JDCMediaContext的videoqueue 得到AVPacket;
// 2.frame 同步
// 3.AVPacket -> AVFrame
// 4.JDCMediaContext 的videoFrameQueue 装入AVFrame
int jdc_media_video_thread(void *data)
{
    JDCMediaContext *mCtx = data;
    mCtx->videoFrameQueue = jdc_packet_queue_alloc();
    jdc_packet_queue_init(mCtx->videoFrameQueue);
    
    while(1){
        
        AVFrame *pFrame = av_frame_alloc();
        AVPacket *packet;
        
        //这个方法从视频packet队列里面取出一个packet进行解码，注意如果队列为空这里会
        //挂起，packet新加到队列则会唤醒此线程。
        if(jdc_packet_queue_get_packet(mCtx->videoQueue, (void **)&packet, 1) < 0) {
            av_frame_free(&pFrame);
            break;
        }
        
        //将packet数据送给解码器。
         int r = avcodec_send_packet(mCtx->codecCtxVideo, packet);
         if (r != 0) {
            av_packet_unref(packet);
            av_packet_free(&packet);
             continue;
         }
        
        //尝试获取解码结果
         r = avcodec_receive_frame(mCtx->codecCtxVideo, pFrame);
         if (r != 0) {
            av_packet_unref(packet);
            av_packet_free(&packet);
             continue;
         }
        
        double pst = 0;
        if (packet->dts != AV_NOPTS_VALUE) {
            pst = av_frame_get_best_effort_timestamp(pFrame);
        }
        pst *= av_q2d(mCtx->videoStream->time_base);
        pst = synchronize_video(mCtx, pFrame, pst);
        
        JDCVideoFrame *vFrame = jdc_video_Frame_alloc();
        vFrame->avFrame = pFrame;
        vFrame->pts = pst;
        
        //解码成功，将解码好的视频帧数据放到帧队列。
        jdc_packet_queue_push(mCtx->videoFrameQueue, vFrame);
        av_packet_unref(packet);
        av_packet_free(&packet);
    }

    return 0;
}

/* 1.填充JDCMediaContext 的codec codecContext;
   2.创建
 
 // 找到视频流和音频流以后我们需要找到对应的解码器并且打开流，做好解码的准备。
 */
int jdc_media_open_stream(JDCMediaContext *mCtx , int sIdx){
    
    AVFormatContext *pFormatCtx = mCtx->fmtCtx; // 传递格式上下文
    AVCodecContext *codecCtx = NULL; // 解码上下文
    AVCodec *codec = NULL;// 解码器
    
//    判断不符合要求的错误
    if (sIdx < 0 || sIdx >= pFormatCtx->nb_streams) {
        return -1;
    }
    
    AVStream *stream = pFormatCtx->streams[sIdx]; // 获取到当前的流
    
//    找到解码器
    codec = avcodec_find_decoder(stream->codecpar->codec_id);
//    看看是否有对应的解码器
    if (!codec) {
        fprintf(stderr, "Unsupported codec!\n");
        return -1;
    }
    
//获取解码上下文
    codecCtx = avcodec_alloc_context3(codec);
//    配置解码上下文
    if(avcodec_parameters_to_context(codecCtx, stream->codecpar) < 0){
        fprintf(stderr, "avcodec parameters to context failed!\n");
        return -1;
    }
    
//    sdL的配置
    if (codecCtx->codec_type == AVMEDIA_TYPE_AUDIO) {
        SDL_AudioSpec wanted_spec;
        SDL_AudioSpec spec;
        wanted_spec.freq = codecCtx->sample_rate;
        wanted_spec.format = AUDIO_S16SYS;
        wanted_spec.channels = codecCtx->channels;
        wanted_spec.silence = 0;
        wanted_spec.samples = 1024;
        wanted_spec.callback = jdc_sdl_audio_callback;
        wanted_spec.userdata = mCtx;
        
        //音频回调，我在这个回调中向音频设备feed数据。
        if(SDL_OpenAudio(&wanted_spec, &spec) < 0) {
            fprintf(stderr, "SDL_OpenAudio: %s\n", SDL_GetError());
            return -1;
        }
    }
    
    //    解码器打开     //打开流开始解码
    if(avcodec_open2(codecCtx, codec, NULL) < 0) {
        fprintf(stderr, "Unsupported codec!\n");
        return -1;
    }
    
    
    switch(codecCtx->codec_type) {
        case AVMEDIA_TYPE_AUDIO:// 音频解码
            mCtx->audioStreamIdx = sIdx;
            mCtx->audioStream = stream;
            mCtx->codecAudio = codec;
            mCtx->codecCtxAudio = codecCtx;
            mCtx->audioQueue = jdc_packet_queue_alloc();
            jdc_packet_queue_init(mCtx->audioQueue);
            SDL_PauseAudio(0);
            break;
        case AVMEDIA_TYPE_VIDEO: // 视频解码
            mCtx->frame_timer = (double)av_gettime() / 1000000.0;
            mCtx->frame_last_delay = 40e-3;
            mCtx->videoStreamIdx = sIdx;
            mCtx->videoStream = stream;
            mCtx->codecVideo = codec;
            mCtx->codecCtxVideo = codecCtx;
            mCtx->videoQueue = jdc_packet_queue_alloc();
            mCtx->video_tid = SDL_CreateThread(jdc_media_video_thread,
                                               "video thread",
                                               mCtx);
            jdc_packet_queue_init(mCtx->videoQueue);
            mCtx->swsCtx = sws_getContext(mCtx->codecCtxVideo->width,
                                           mCtx->codecCtxVideo->height,
                                           mCtx->codecCtxVideo->pix_fmt,
                                           mCtx->codecCtxVideo->width,
                                           mCtx->codecCtxVideo->height,
                                           AV_PIX_FMT_YUV420P,
                                           SWS_BILINEAR,
                                           NULL,
                                           NULL,
                                           NULL);
            break;
        default:
            break;
    }
    
    return 0;
}

// 创建媒体解码线程
int jdc_media_decode_thread(void *userData)
{
    JDCMediaContext *mCtx = userData;
//    媒体上下文
    
    AVFrame *pFrame = NULL;
    pFrame = av_frame_alloc();
    
    if (pFrame == NULL) {
        return -1;
    }
    
//    int numBytes;
//    numBytes = av_image_get_buffer_size(AV_PIX_FMT_YUV420P,
//                                        mCtx->codecCtxVideo->width,
//                                        mCtx->codecCtxVideo->height,
//                                        1);
    AVPacket *packet;
    //这个方法的核心就是不断的读取视频文件数据，存储到AVPacket结构
    //视频则放到视频packet队列，音频则放到音频packet队列。
    int ret = -1;
    do{
        packet = av_packet_alloc();
        ret = av_read_frame(mCtx->fmtCtx, packet);
        if (ret >= 0) {
            if (packet->stream_index == mCtx->videoStream->index) {
                jdc_packet_queue_push(mCtx->videoQueue, packet);
            }else if(packet->stream_index == mCtx->audioStream->index){
                jdc_packet_queue_push(mCtx->audioQueue, packet);
            }
        }
    }while(ret >= 0);
    
    
    return 0;
}

//打开媒体输入
JDCMediaContext *jdc_media_open_input(const char *url,JDCError **error)
{
    JDCMediaContext *mCtx = (JDCMediaContext *)av_mallocz(sizeof(JDCMediaContext));
//    媒体上下文分配获取
    
    AVFormatContext *pFmtCtx = avformat_alloc_context();
//    媒体格式上下文分配获取
    
    strcpy(mCtx->filename, url); // 拷贝传入的url到对应的结构体的文件名上
    
//     是否可以打开
    if (avformat_open_input(&pFmtCtx, url, NULL, NULL) != 0) {
        av_free(mCtx);
        return NULL;
    }
    
//     格式上下文是媒体上下文的一个属性 （媒体上下文更大）
    mCtx->fmtCtx = pFmtCtx;
    
//     查找是否有流输入？？？
    if (avformat_find_stream_info(pFmtCtx, NULL) < 0) {
        av_free(mCtx);
        return NULL;
    }
    
//      Dump information about file onto standard error
    av_dump_format(pFmtCtx, 0, mCtx->filename, 0);
//     输出有关标准的信息

//      找到文件中的视频流和音频流  pFmtCtx->nb_streams 表示流的数目（个数）
    for(int i = 0 ; i < pFmtCtx->nb_streams ; i++){
        if(pFmtCtx->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO &&
           mCtx->videoStream == NULL){
            mCtx->videoStreamIdx = i;
        }
        
        if(pFmtCtx->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_AUDIO &&
           mCtx->audioStream == NULL){
            mCtx->audioStreamIdx = i;
        }
    }
//    至于里面的逻辑是什么就不知道了
//     反正就是讲有关的输入信息，转化为媒体上下文对象
    
    return mCtx;
}
static Uint32 sdl_refresh_timer_cb(Uint32 interval, void *opaque) {
    SDL_Event event;
    event.type = FF_REFRESH_EVENT;
    event.user.data1 = opaque;
    SDL_PushEvent(&event);
    return 0; /* 0 means stop timer */
}

int schedule_refresh(JDCMediaContext *mCtx, int n)
{
    return SDL_AddTimer(n, sdl_refresh_timer_cb, mCtx);
}

// 绘制视频到window上
int video_display(JDCMediaContext *mCtx , void *data) {
    
    AVFrame *pFrameYUV = mCtx->sdlCtx->frame;

    JDCVideoFrame *vFrame = data;
    AVFrame *pFrame = vFrame->avFrame;
    JDCSDLContext *sdlCtx = mCtx->sdlCtx;
    
    struct SwsContext *swsCtx = mCtx->swsCtx;
    
    sws_scale(swsCtx,
              (uint8_t  const * const *)pFrame->data,
              pFrame->linesize,
              0,
              pFrame->height,
              pFrameYUV->data,
              pFrameYUV->linesize);
    
    SDL_Rect sdlRect;
    sdlRect.x = 0;
    sdlRect.y = 0;
    sdlRect.w = pFrame->width;
    sdlRect.h = pFrame->height;
    
    SDL_UpdateYUVTexture(sdlCtx->texture, &sdlRect,
                         pFrameYUV->data[0], pFrameYUV->linesize[0],
                         pFrameYUV->data[1], pFrameYUV->linesize[1],
                         pFrameYUV->data[2], pFrameYUV->linesize[2]);
    
    SDL_RenderClear(sdlCtx->renderer );
    SDL_RenderCopy( sdlCtx->renderer, sdlCtx->texture,NULL, &sdlRect );
    SDL_RenderPresent( sdlCtx->renderer );
    
    jdc_video_Frame_free(vFrame);
    
    return 0;
}

static double get_audio_clock(JDCMediaContext *mCtx)
{
    double pts;
    int hw_buf_size, bytes_per_sec, n;
    
    pts = mCtx->audio_clock; /* maintained in the audio thread */
    hw_buf_size = mCtx->audio_buf_size - mCtx->audio_buf_index;
    bytes_per_sec = 0;
    n = mCtx->audioStream->codecpar->channels * 2;
    if(mCtx->audioStream) {
        bytes_per_sec = mCtx->audioStream->codecpar->sample_rate * n;
    }
    if(bytes_per_sec) {
        pts -= (double)hw_buf_size / bytes_per_sec;
    }
    return pts;
}

// 刷新定会器
void video_refresh_timer(void *userdata) {
    
    JDCMediaContext *mCtx = (JDCMediaContext *)userdata;
    
    if(mCtx->videoStream) {
        if(jdc_packet_queue_size(mCtx->videoFrameQueue) == 0) {
            schedule_refresh(mCtx, 1);
        } else {
            JDCVideoFrame *vFrame = NULL;
            jdc_packet_queue_get_packet(mCtx->videoFrameQueue, (void *)&vFrame, 1);
            double actual_delay, delay, sync_threshold, ref_clock, diff;
            delay = vFrame->pts - mCtx->frame_last_pts; /* the pts from last time */
            if(delay <= 0 || delay >= 1.0) {
                /* if incorrect delay, use previous one */
                delay = mCtx->frame_last_delay;
            }
            /* save for next time */
            mCtx->frame_last_delay = delay;
            mCtx->frame_last_pts = vFrame->pts;
            
            /* update delay to sync to audio */
            ref_clock = get_audio_clock(mCtx);
            diff = vFrame->pts - ref_clock;
            
            /* Skip or repeat the frame. Take delay into account
             FFPlay still doesn't "know if this is the best guess." */
            sync_threshold = (delay > AV_SYNC_THRESHOLD) ? delay : AV_SYNC_THRESHOLD;
            if(fabs(diff) < AV_NOSYNC_THRESHOLD) {
                if(diff <= -sync_threshold) {
                    delay = 0;
                } else if(diff >= sync_threshold) {
                    delay = 2 * delay;
                }
            }
            mCtx->frame_timer += delay;
            /* computer the REAL delay */
            actual_delay = mCtx->frame_timer - (av_gettime() / 1000000.0);
            if(actual_delay < 0.010) {
                /* Really it should skip the picture instead */
                actual_delay = 0.010;
            }
            schedule_refresh(mCtx, (int)(actual_delay * 1000 + 0.5));
            /* show the picture! */
//             绘制视频到window上
            video_display(mCtx,vFrame);
        }
    } else {
        schedule_refresh(mCtx, 100);
    }
}

// 这里是媒体播放 （播放里面就包括了对应的解码）
int jdc_media_play(JDCMediaContext *mCtx)
{
    jdc_media_open_stream(mCtx, mCtx->audioStreamIdx);
    jdc_media_open_stream(mCtx, mCtx->videoStreamIdx);
    mCtx->sdlCtx = jdc_sdl_create_context(mCtx);
//    获取音视频流 和sdl上下文
    
    SDL_Event event;
    schedule_refresh(mCtx, 40);
    
//     获取创阿金sdl的线程
    mCtx->parse_tid = SDL_CreateThread(jdc_media_decode_thread, "decode thread",mCtx);
    
    
    if(!mCtx->parse_tid) {
        return -1;
    }
    
    
    while(1){
//         timer触发事件，从视频帧队列中拿出数据，绘制到屏幕上
        SDL_WaitEvent(&event);
        switch(event.type) {
            case FF_QUIT_EVENT:
            case SDL_QUIT:
                mCtx->quit = 1;
                SDL_Quit();
                return 0;
                break;
            case FF_REFRESH_EVENT:
                video_refresh_timer(event.user.data1);
                break;
            default:
                break;
        }
    }
    return 0;
}
