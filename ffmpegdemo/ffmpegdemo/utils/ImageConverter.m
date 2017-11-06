//
//  ImageConverter.m
//  ffmpegdemo
//
//  Created by neil on 2017/11/2.
//  Copyright © 2017年 weixin. All rights reserved.
//

#import "ImageConverter.h"
#import "swscale.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation ImageConverter


+ (UIImage*)imageFromAVFrame:(AVFrame *)avFrame
{
    AVPicture avPicture;
    
    float width = avFrame->width;
    float height = avFrame->height;
    
    //    avpicture_free(&avPicture);
    avpicture_alloc(&avPicture, AV_PIX_FMT_RGB24, width, height);
    
    struct SwsContext * imgConvertCtx = sws_getContext(avFrame->width,
                                                       avFrame->height,
                                                       AV_PIX_FMT_YUV420P,
                                                       width,
                                                       height,
                                                       AV_PIX_FMT_RGB24,
                                                       SWS_FAST_BILINEAR,
                                                       NULL,
                                                       NULL,
                                                       NULL);
    if(imgConvertCtx == nil) return nil;
    
    sws_scale(imgConvertCtx,
              avFrame->data,
              avFrame->linesize,
              0,
              avFrame->height,
              avPicture.data,
              avPicture.linesize);
    sws_freeContext(imgConvertCtx);
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CFDataRef data = CFDataCreate(kCFAllocatorDefault,
                                  avPicture.data[0],
                                  avPicture.linesize[0] * height);
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef cgImage = CGImageCreate(width,
                                       height,
                                       8,
                                       24,
                                       avPicture.linesize[0],
                                       colorSpace,
                                       bitmapInfo,
                                       provider,
                                       NULL,
                                       NO,
                                       kCGRenderingIntentDefault);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(provider);
    CFRelease(data);
    
    return image;
}

@end
