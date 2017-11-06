//
//  main.m
//  ffmpegdemo
//
//  Created by neil on 2017/2/5.
//  Copyright © 2017年 weixin. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//ffmpeg head file
#import "avformat.h"
#import "imgutils.h"
#import "swscale.h"

//SDL head file
#import <SDL2/SDL.h>

void playVideo(const char *path);
void init();

int main(int argc, char * argv[]) {
    @autoreleasepool {
        init();
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shortVideo" ofType:@"mp4"];
        playVideo(path.UTF8String);
        return 1;
    }
}

void init() {
    //register codec
    av_register_all();
    
    SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER);
    
}

void playVideo(const char *path) {
    AVFormatContext *formatCtx = avformat_alloc_context();
    //填充AVFormatContext 的codec id and type
    if (avformat_open_input(&formatCtx, path, NULL, NULL) != 0) {
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
    
    SDL_Window *window = SDL_CreateWindow("play video", 0, 0, codecCtx->width, codecCtx->height, SDL_WINDOW_ALLOW_HIGHDPI);
    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, 0);
    
    SDL_Texture *texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_IYUV, SDL_TEXTUREACCESS_STREAMING, codecCtx->width, codecCtx->height);
    SDL_Rect rect;
    rect.x = 0;
    rect.y = 0;
    rect.w = codecCtx -> width;
    rect.h = codecCtx -> height;
    
    //该矩形决定了最终播放界面的大小
    SDL_Rect dstRect;
    dstRect.x = 0;
    dstRect.y = 0;
    dstRect.w = codecCtx -> width;
    dstRect.h = codecCtx -> height;
    
    struct SwsContext *swsCtx = sws_getContext(codecCtx -> width, codecCtx -> height, codecCtx->pix_fmt, codecCtx->width, codecCtx->height, AV_PIX_FMT_YUV420P, SWS_BILINEAR, NULL, NULL, NULL);
//    int finished = 0;
    
    
    while (1) {
        SDL_Event event;
        SDL_WaitEvent(&event);
        switch (event.type) {
            case SDL_QUIT:
                SDL_Quit();
                exit(1);
                break;
            case SDL_FINGERDOWN:
                break;
        }
        av_seek_frame(formatCtx, videoStreamIdx, 0, AVSEEK_FLAG_ANY);
        while (av_read_frame(formatCtx, &packet) >= 0 ) {
            if (packet.stream_index == videoStreamIdx) {
                avcodec_send_packet(codecCtx, &packet);
                avcodec_receive_frame(codecCtx, pFrame);
//                avcodec_decode_video2(codecCtx, pFrame, &finished, &packet);
//                if (finished) {
                    sws_scale(swsCtx, (uint8_t const * const *)pFrame->data, pFrame->linesize,0, codecCtx->height, pFrameYUV->data, pFrameYUV->linesize);
                    SDL_UpdateYUVTexture(texture, &rect, pFrameYUV->data[0], pFrameYUV->linesize[0], pFrameYUV->data[1], pFrameYUV->linesize[1], pFrameYUV->data[2], pFrameYUV->linesize[2]);
                    
                    SDL_SetWindowSize(window, codecCtx->width/2, codecCtx->height/2);
                    
                    int w,h;
                    SDL_GetWindowSize(window, &w, &h);
                    
                    
                    SDL_RenderClear(renderer);
                    SDL_RenderCopy(renderer, texture, &rect, &dstRect);
                    SDL_RenderPresent(renderer);
                    SDL_Delay(50);
//                }
                av_free_packet(&packet);
            }
            
        }
    }

    SDL_DestroyTexture(texture);
    av_free(pFrame);
    av_free(pFrameYUV);
    
    avcodec_close(codecCtx);
    
    avformat_close_input(&formatCtx);
}

