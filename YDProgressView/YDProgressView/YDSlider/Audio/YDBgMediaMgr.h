//
//  YDBgMediaMgr.h
//  SportsBar
//
//  Created by Aka on 2017/8/24.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YDMedia;
@class AVAudioPlayer;
@class YDPannelINfo;

@interface YDBgMediaMgr : NSObject


typedef void(^CurrentPlayInfo)(YDPannelINfo *info);

+ (instancetype)shared;

- (void)playWithMedia:(YDMedia *)media;

- (void)playWithUrlString:(NSString *)mediaUrlString;
- (void)pause;
- (void)stop;
- (void)continousPlay;

- (void)playAtTime:(NSTimeInterval)progress; /* 0.f ~1.f */

- (void)nextTrack:(CurrentPlayInfo)currentPlayInfo;
- (void)previousTrack:(CurrentPlayInfo)currentPlayInfo;
- (void)playOrPause:(CurrentPlayInfo)currentPlayInfo;

@property (nonatomic, strong, readonly) YDMedia *media;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (void)destroyTimer;

// media image hidden

- (void)setHiddenHoverBtn:(BOOL)flag;

@end
