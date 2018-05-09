//
//  ViewController.m
//  FFMpegForIOSDemo
//
//  Created by Aka on 2017/11/5.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"

//1）
#import <libavformat/avformat.h>
#import <libswscale/swscale.h>
#import <libswresample/swresample.h>
#import <libavutil/pixdesc.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test0];
}


- (void)test0 {
//    2）
    avformat_network_init(); // 初始化视频的网络格式
    av_register_all(); // 注册所有的视频
    
//    3）
    AVFormatContext *formatCtx = avformat_alloc_context();
    AVIOInterruptCB int_cb = { interrupt_callback, (__bridge void *)(self)};
    formatCtx->interrupt_callback = int_cb;
    NSString *path = @"";
    avformat_open_input(formatCtx, path, NULL, NULL);
    avformat_find_stream_info(formatCtx, NULL);
    
//    4）寻找音视频流
    int videoStreamIndex =-1;
    int audioStreamIndex =-1;
    for (int i =0; i <formatCtx->nb_streams; i++) {
        AVStream *stream = formatCtx->streams[i];
        if (AVMEDIA_TYPE_VIDEO == stream->codec->codec_type) {
            videoStreamIndex = i;
        }
        if (AVMEDIA_TYPE_AUDIO == stream->codec->codec_type) {
            audioStreamIndex = i;
        }
    }
    
//    5) 打开音视频解码器
    AVCodecContext *audioCodecCtx = audioStream -codec;
    AVCodec *codec = avcodec_find_decoder(audioCodecCtx ->codec_id);
    if (!codec) {
//        找不到对应的音频解码器
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
