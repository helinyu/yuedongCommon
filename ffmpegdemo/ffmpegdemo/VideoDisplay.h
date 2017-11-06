//
//  VideoDisplay.h
//  ffmpegdemo
//
//  Created by neil on 2017/11/1.
//  Copyright © 2017年 weixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VideoDisplay : NSObject

- (void)playVideoWithPath:(NSString *)videoPath;

- (void)playVideo:(NSString *)videoPath;

@end
