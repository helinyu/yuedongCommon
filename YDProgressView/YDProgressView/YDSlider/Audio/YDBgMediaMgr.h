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
//@property (nonatomic, copy) CurrentPlayInfo currentPlayInfo;

+ (instancetype)shared;

- (void)playWithMedia:(YDMedia *)media;

- (void)playWithUrlString:(NSString *)mediaUrlString;
- (void)pause;
- (void)stop;
- (void)continousPlay;

- (void)nextTrack:(CurrentPlayInfo)currentPlayInfo;
- (void)previousTrack:(CurrentPlayInfo)currentPlayInfo;
- (void)playOrPause:(CurrentPlayInfo)currentPlayInfo;

@property (nonatomic, strong, readonly) YDMedia *media;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end
