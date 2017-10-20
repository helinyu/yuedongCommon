//
//  YDVideoView.m
//  test_effective
//
//  Created by Aka on 2017/10/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDVideoView.h"
#import <AVFoundation/AVFoundation.h>

@implementation YDVideoView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

@end
