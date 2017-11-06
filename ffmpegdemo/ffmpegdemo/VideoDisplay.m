//
//  VideoDisplay.m
//  ffmpegdemo
//
//  Created by neil on 2017/11/1.
//  Copyright © 2017年 weixin. All rights reserved.
//

#import "VideoDisplay.h"
#import "avformat.h"
#import "avcodec.h"
#import "imgutils.h"
#import "swscale.h"
#import <libavformat/avformat.h>
#import <libswscale/swscale.h>

#import <SDL2/SDL.h>
#import <SDL2/SDL_thread.h>

#import "ImageConverter.h"

@interface VideoDisplay()

@end

@implementation VideoDisplay

- (instancetype)init
{
    self = [super init];
    if (self) {
        //注册所有的编解码器
        av_register_all();
        
        int result = SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER);
        
        char *error = SDL_GetError();
        
        if (result) {
            NSLog(@"init sdl fail");
            exit(-1);
        }
    }
    return self;
}

- (void)playVideoWithPath:(NSString *)videoPath {
//一. 视频解码
    AVFormatContext *formatContext = avformat_alloc_context();
    if (avformat_open_input(&formatContext, videoPath.UTF8String, NULL, NULL)) {
        NSLog(@"open file fail");
        exit(1);
    }
    if (avformat_find_stream_info(formatContext, NULL) != 0) {
        NSLog(@"can not find stream info");
        exit(1);
    }
    
    int videoStreamIndex = -1;
    for (int i = 0; i < formatContext -> nb_streams; i++) {
        if (formatContext -> streams[i] -> codecpar -> codec_type == AVMEDIA_TYPE_VIDEO) {
            videoStreamIndex = i;
            break;
        }
    }
    if (videoStreamIndex == -1) {
        NSLog(@"not find video stream");
        exit(1);
    }
    av_dump_format(formatContext, videoStreamIndex, videoPath.UTF8String, 0);

    //找到视频流
    AVStream *videoStream = formatContext -> streams[videoStreamIndex];
    
    AVCodecContext *codecContext = videoStream -> codec;
    
    //找到对应的编码器
    AVCodec *codec = avcodec_find_decoder(codecContext -> codec_id);
    //打开编码器
    if (avcodec_open2(codecContext, codec, NULL) < 0) {
        NSLog(@"open codec fail");
        exit(1);
    }
    
    AVFrame *frameYUV = av_frame_alloc();
    AVFrame *pFrame = av_frame_alloc();
    if ((frameYUV == NULL) || (pFrame == NULL)) {
        NSLog(@"frame is NULL");
        exit(1);
    }
    
    AVPacket packet;
    int frameFinished;
//二. 视频渲染
    SDL_Window *screen = SDL_CreateWindow("videoDisplay", 0, 0, codecContext -> width, codecContext -> height, SDL_WINDOW_FULLSCREEN | SDL_WINDOW_OPENGL);
    SDL_Renderer *render = SDL_CreateRenderer(screen, -1, 0);
    
    SDL_Texture *bmp = SDL_CreateTexture(render, SDL_PIXELFORMAT_YV12, SDL_TEXTUREACCESS_STREAMING, codecContext -> width, codecContext -> height);
    
    //原格式转换为
    struct SwsContext *sws_ctx = sws_getContext(codecContext->width, codecContext->height, codecContext->pix_fmt, codecContext->width, codecContext->height, AV_PIX_FMT_YUV410P, SWS_BILINEAR, NULL, NULL, NULL);
//    int numBytes = avpicture_get_size(AV_PIX_FMT_YUV420P, codecContext->width,codecContext->height);
//    uint8_t* buffer = (uint8_t *)av_malloc(numBytes*sizeof(uint8_t));
//    avpicture_fill((AVPicture *)frameYUV, buffer, AV_PIX_FMT_YUV420P,
//                   codecContext->width, codecContext->height);
    
    unsigned char *   out_buffer=(unsigned char *)av_malloc(av_image_get_buffer_size(AV_PIX_FMT_YUV420P,  codecContext->width, codecContext->height,1));

    av_image_fill_arrays(frameYUV->data, frameYUV->linesize, out_buffer, AV_PIX_FMT_YUV420P, codecContext->width, codecContext->height, 1);
    
    SDL_Rect rect;
    rect.x = 0;
    rect.y = 0;
    rect.w = codecContext->width;
    rect.h = codecContext->height;
    
    SDL_Event event;
    while (av_read_frame(formatContext, &packet) >= 0) {
        if (packet.stream_index == videoStreamIndex) {
            avcodec_decode_video2(codecContext, pFrame, &frameFinished, &packet);
            if (frameFinished) {
//                UIImage *image = [ImageConverter imageFromAVFrame:pFrame];
                
                sws_scale(sws_ctx, (uint8_t const * const *)pFrame->data, pFrame->linesize, 0, codecContext->height, frameYUV->data, frameYUV -> linesize);
                SDL_UpdateYUVTexture(bmp, &rect,
                                     frameYUV->data[0], frameYUV->linesize[0],
                                     frameYUV->data[1], frameYUV->linesize[1],
                                     frameYUV->data[2], frameYUV->linesize[2]);
                SDL_RenderClear(render);
                SDL_RenderCopy(render, bmp, &rect, &rect);
                SDL_RenderPresent(render);
            }
            SDL_Delay(50);
        }
        av_free_packet(&packet);
        SDL_PollEvent(&event);
        switch(event.type) {
            case SDL_QUIT:
                SDL_Quit();
                exit(0);
                break;
            default:
                break;
        }
    }
    SDL_DestroyTexture(bmp);
    
    // Free the YUV frame
    av_free(pFrame);
    av_free(frameYUV);
    // Close the codec
    avcodec_close(codecContext);
    
    // Close the video file
    avformat_close_input(&formatContext);
}

- (void)playVideo:(NSString *)videoPath {
    AVFormatContext *formatCtx = avformat_alloc_context();
    //填充AVFormatContext 的codec id and type
    if (avformat_open_input(&formatCtx, videoPath.UTF8String, NULL, NULL) != 0) {
        NSLog(@"open input fail");
        exit(-1);
    }
    
    if (avformat_find_stream_info(formatCtx, NULL) < 0) {
        NSLog(@"not find stream info");
        exit(-1);
    }
    
    int videoStreamIdx = -1;
    for (int i = 0; i < formatCtx -> nb_streams; i++) {
        if (formatCtx -> streams[i] -> codecpar ->codec_type == AVMEDIA_TYPE_VIDEO) {
            videoStreamIdx = i;
            break;
        }
    }
    if (videoStreamIdx == -1) {
        NSLog(@"not find video stream");
        exit(-1);
    }
    
    AVCodec *codec = avcodec_find_decoder(formatCtx -> streams[videoStreamIdx] -> codecpar ->codec_id);
    if (!codec) {
        NSLog(@"not find codec");
        exit(-1);
    }
    
    AVCodecContext *codecCtx = avcodec_alloc_context3(codec);
    int result = avcodec_parameters_to_context(codecCtx, formatCtx -> streams[videoStreamIdx] -> codecpar);
    
    if (result < 0) {
        NSLog(@"convert fail");
        exit(-1);
    }
    avcodec_open2(codecCtx, codec, NULL);
    
    AVPacket packet;
    
    AVFrame *pFrame = av_frame_alloc();
    
    AVFrame *pFrameYUV = av_frame_alloc();
    int numBytes = av_image_get_buffer_size(AV_PIX_FMT_YUV420P, codecCtx->width, codecCtx->height, 1);
    
    uint8_t *buffer = (uint8_t *)av_malloc(numBytes);
    
    result = av_image_fill_arrays(pFrameYUV->data, pFrameYUV->linesize, buffer, AV_PIX_FMT_YUV420P, codecCtx->width, codecCtx->height, 1);
    if (result < 0) {
        NSLog(@"fill frameYUV fail");
        exit(-1);
    }
    
    SDL_Window *window = SDL_CreateWindow("play video", 0, 0, codecCtx->width, codecCtx->height, SDL_WINDOW_OPENGL);
    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, 0);
    
    SDL_Texture *texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_IYUV, SDL_TEXTUREACCESS_STREAMING, codecCtx->width, codecCtx->height);
    SDL_Rect rect;
    rect.x = 0;
    rect.y = 0;
    rect.w = codecCtx -> width;
    rect.h = codecCtx -> height;
    
    struct SwsContext *swsCtx = sws_getContext(codecCtx -> width, codecCtx -> height, codecCtx->pix_fmt, codecCtx->width, codecCtx->height, AV_PIX_FMT_YUV420P, SWS_BILINEAR, NULL, NULL, NULL);
    int finished = 0;
    
    SDL_Event event;
    while (av_read_frame(formatCtx, &packet) >= 0 ) {
        if (packet.stream_index == videoStreamIdx) {
            avcodec_decode_video2(codecCtx, pFrame, &finished, &packet);
            if (finished) {
                sws_scale(swsCtx, (uint8_t const * const *)pFrame->data, pFrame->linesize,0, codecCtx->height, pFrameYUV->data, pFrameYUV->linesize);
                SDL_UpdateYUVTexture(texture, &rect, pFrameYUV->data[0], pFrameYUV->linesize[0], pFrameYUV->data[1], pFrameYUV->linesize[1], pFrameYUV->data[2], pFrameYUV->linesize[2]);
                SDL_RenderClear(renderer);
                SDL_RenderCopy(renderer, texture, &rect, &rect);
                SDL_RenderPresent(renderer);
                SDL_Delay(50);
            }
            av_free_packet(&packet);
            SDL_WaitEvent(&event);
            switch (event.type) {
                case SDL_QUIT:
                    SDL_Quit();
                    exit(1);
                    break;
                default:
                    break;
            }
        }
    }
    SDL_DestroyTexture(texture);
    av_free(pFrame);
    av_free(pFrameYUV);
    
    avcodec_close(codecCtx);
    
    avformat_close_input(&formatCtx);

}



@end
