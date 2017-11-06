//
//  VideoDecode.m
//  ffmpegdemo
//
//  Created by neil on 2017/2/5.
//  Copyright © 2017年 weixin. All rights reserved.
//

#import "VideoDecode.h"

#import "libavutil/pixfmt.h"

@interface VideoDecode ()
{
    AVFormatContext *pFormatCtx;
    int i,videoStream;
    AVCodecContext *pCodecCtx;
    AVCodec *pCodec;
    AVFrame *pFrame;    //YUV frame
//    AVFrame *pFrameRGB;
    AVPacket packet;
    int frameFinished;
    int numBytes;
    uint8_t *buffer;
    
    
}
@end
static void SaveFrame(AVFrame *pFrame, int width, int height, int iFrame);

@implementation VideoDecode

- (instancetype)init
{
    self = [super init];
    if (self) {
        pFormatCtx = NULL;
        av_register_all();
    }
    return self;
}

- (BOOL)decodeWithVideoPath:(NSString *)filepath {
    if (avformat_open_input(&pFormatCtx, [filepath UTF8String], NULL, NULL) != 0) {
        return NO;
    }
    if (avformat_find_stream_info(pFormatCtx, NULL) != 0) {
        return NO;
    }
    
    av_dump_format(pFormatCtx, -1, [filepath UTF8String], 0);
    
    videoStream = -1;
    for (int i = 0; i < pFormatCtx -> nb_streams; i++) {
        if (pFormatCtx -> streams[i] -> codec -> codec_type == AVMEDIA_TYPE_VIDEO) {
            videoStream = i;
            break;
        }
    }
    if (videoStream == -1) {
        return NO;
    }
    
    pCodecCtx = pFormatCtx -> streams[videoStream] -> codec;
    pCodec = avcodec_find_decoder(pCodecCtx -> codec_id);
    if (pCodec == NULL) {
        return NO;
    }
    
    if ( avcodec_open2(pCodecCtx, pCodec, NULL) <0 ) {
        return NO;
    }
    
    pFrame = av_frame_alloc();
    if ( pFrame == NULL ) {
        return NO;
    }
    
//    pFrameRGB = av_frame_alloc();
//    if (pFrameRGB == NULL) {
//        return NO;
//    }
    
    numBytes = avpicture_get_size(AV_PIX_FMT_RGB24, pCodecCtx -> width, pCodecCtx -> height);
    
    buffer = av_malloc(numBytes);
    
//    avpicture_fill((AVPicture *)pFrameRGB, buffer, AV_PIX_FMT_RGB24, pCodecCtx -> width, pCodecCtx -> height);
    
    
//    SDL_Surface *screen;
    
//    screen = SDL_SetVideoMode(pCodecCtx->width)
    
    i = 0;
    while ( av_read_frame(pFormatCtx, &packet) >= 0 ) {
        if ( packet.stream_index == videoStream ) {
            avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, &packet);
            if ( frameFinished ) {
//                struct SwsContext *img_convert_ctx = NULL;
//                img_convert_ctx = sws_getCachedContext(img_convert_ctx, pCodecCtx -> width, pCodecCtx -> height, pCodecCtx -> pix_fmt, pCodecCtx -> workaround_bugs, pCodecCtx -> height, AV_PIX_FMT_RGB24, SWS_BICUBIC, NULL, NULL, NULL);
//                if ( !img_convert_ctx ) {
//                    NSLog(@"can't initialize sws context");
//                    exit(1);
//                }
//                sws_scale(img_convert_ctx, (const uint8_t * const *) pFrame -> data, pFrame -> linesize, 0, pCodecCtx -> height, pFrameRGB -> data, pFrameRGB -> linesize);
                if ([self.delegate respondsToSelector:@selector(outputFrame:frameSequence:Size:)]) {
                    [self.delegate outputFrame:pFrame frameSequence:i Size:CGSizeMake(pCodecCtx->width, pCodecCtx->height)];
                }
            }
        }
        av_free_packet(&packet);
    }
    
    av_free(buffer);
//    av_free(pFrameRGB);
    av_free(pFrame);
    avcodec_close(pCodecCtx);
    avformat_close_input(&pFormatCtx);
    
    return YES;
}

static void SaveFrame(AVFrame *pFrame, int width, int height, int iFrame)
{
    FILE *pFile;
    const char *szFilename;
    int y;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/frame%d.ppm",documentsDirectory,iFrame];
    
//    sprintf(szFilename, "frame%d.ppm", iFrame);
    
    szFilename = [filePath UTF8String];
    pFile = fopen(szFilename, "wb");
    if( !pFile )
        return;
    fprintf(pFile, "P6\n%d %d\n255\n", width, height);
    
    for( y = 0; y < height; y++ )
        fwrite(pFrame->data[0] + y * pFrame->linesize[0], 1, width * 3, pFile);
//    pgm_save(pFrame -> data[0], pFrame -> linesize[0], width, height, szFilename);
    
    
    fclose(pFile);
    
}

@end









