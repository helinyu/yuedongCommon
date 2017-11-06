//
//  VideoDecode.h
//  ffmpegdemo
//
//  Created by neil on 2017/2/5.
//  Copyright © 2017年 weixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "imgutils.h"
#import "avcodec.h"
#import "avformat.h"
#import "attributes.h"
#import "swscale.h"
#import "avdevice.h"

@protocol VideoDecodeDelegate;
@interface VideoDecode : NSObject

@property (nonatomic, weak) id<VideoDecodeDelegate> delegate;

- (BOOL)decodeWithVideoPath:(NSString *)filepath;

//- (UIImage*)imageFromAVFrame:(AVFrame *)avFrame;

@end


@protocol VideoDecodeDelegate <NSObject>

- (void)outputFrame:(AVFrame *)frame frameSequence:(NSInteger)sequence Size:(CGSize)size;

@end
