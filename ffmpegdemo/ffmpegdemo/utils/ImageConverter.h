//
//  ImageConverter.h
//  ffmpegdemo
//
//  Created by neil on 2017/11/2.
//  Copyright © 2017年 weixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "avformat.h"

@interface ImageConverter : NSObject
+ (UIImage*)imageFromAVFrame:(AVFrame *)avFrame;

@end
