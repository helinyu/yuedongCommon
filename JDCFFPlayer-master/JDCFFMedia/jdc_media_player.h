//
//  jdc_media_player.h
//  JDCFFPlayer
//
//  Created by Jidong Chen on 01/04/2017.
//  Copyright © 2017 jidong. All rights reserved.
//

#ifndef jdc_media_player_h
#define jdc_media_player_h

#include "avformat.h"
#include "avcodec.h"
#include "swscale.h"
#include "avutil.h"
#include "imgutils.h"
#include "jdc_sdl.h"


struct JDCMediaContext {
    
    AVFormatContext *fmtCtx; // 视频文件(格式)上下文

//    下面是编码和解码的数据结构
    //     视频
    AVCodec *codecVideo; // 视频解码器
    AVCodecContext *codecCtxVideo; // 视频解码上下文
 
    AVStream *videoStream;  // 视频流
    int videoStreamIdx;  // 视频流在format的index
//     也就是说，这两个变量表明了在 AVFormatContext 上面的内容
    
//    音频
    AVCodec *codecAudio;  // 音频解码器åå
    AVCodecContext *codecCtxAudio; //音频解码上下文
    AVStream *audioStream;  // 音频流
    int audioStreamIdx; // 音频在format上的index
    
    JDCSDLContext *sdlCtx; //SDL2.0 上下文 ，这个是渲染的上下文
    
    SDL_Thread *parse_tid;  // 解包现成的tid
    SDL_Thread *video_tid;  // 视频解码线程tid
    
    struct SwsContext *swsCtx;  // AVFrame 变换上下文 (不知道干嘛的)
    JDCSDLPacketQueue *audioQueue;  // 音频packet 队列
    JDCSDLPacketQueue *videoQueue;   // 视频packet队列
    
    JDCSDLPacketQueue *videoFrameQueue;  // 解码完成的视频队列
    
    char filename[1024];  // 文件名
    
    int quit;  // 退出标志
    
    double videoClock;   // 视频时钟
    double frame_last_pts;  // 最新的线程？？？
    double frame_last_delay;  // 最新的延迟
    double frame_timer;  // 帧的计时器
    
    double audio_clock;  /// 音频时钟
    int audio_buf_index;  // 音频缓存下标
    int audio_buf_size;   //音频缓存大小
};

typedef struct JDCMediaContext JDCMediaContext;  // 为什么需要给自己重命名给自己呢？？？

typedef struct JDCError {
}JDCError; // 错误码结构体


int jdc_media_init();  // 媒体初始化

JDCMediaContext *jdc_media_open_input(const char *url,JDCError **error);
// 打开视频文件

int jdc_media_play(JDCMediaContext *mCtx);
//播放视频文件

#endif /* jdc_media_player_h */
