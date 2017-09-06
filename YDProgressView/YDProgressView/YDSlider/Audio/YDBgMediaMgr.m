//
//  YDBgMediaMgr.m
//  SportsBar
//
//  Created by Aka on 2017/8/24.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import "YDBgMediaMgr.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "YDMedia.h"
#import "YYWebImage.h"
#import "RCDraggableButton.h"
#import "YDAudioControlPannelMgr.h"
#import "YDPannelINfo.h"

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

@interface YDBgMediaMgr ()

@property (nonatomic, strong) YDMedia *media;
@property (nonatomic, assign) NSTimeInterval nowSecondTime;
//@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) NSTimer *audioTimeTimer;


@property (nonatomic, strong) RCDraggableButton *hoverBtn;

@end

@implementation YDBgMediaMgr

- (void)dealloc{
    [self destroyTimer];
    [self removeObserver];
}

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (void)playWithMedia:(YDMedia *)media {
    _media = media;
    YDMediaItem *currentItem = _media.mediaItemList[_media.currentIndex];
    [self playWithUrlString:currentItem.mediaUrlStr];
    [self _configureLockLightScreenWithMedia:currentItem];
    [self _createRemoteCommandCenter];
    
    [self initHoverBtn];
}

- (void)playWithUrlString:(NSString *)mediaUrlString {
    
    NSURL *mediaUrl;
    if (![mediaUrlString hasPrefix:@"http"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:mediaUrlString ofType:nil];
        mediaUrl = [NSURL fileURLWithPath:path];
    }else{
        mediaUrl = [NSURL URLWithString:mediaUrlString];
    }
    
    NSError *error = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mediaUrl error:&error];
    if (error) {
        NSLog(@"初始化播放音频失败");
        return;
    }
    BOOL playState = [_audioPlayer play];
    if (!playState) {
        NSLog(@"播放失败");
    }
    
    [self resetTimer];
}

- (void)pause {
    if (_audioPlayer) {
        [_audioPlayer pause];
    }
}

- (void)stop {
    if (_audioPlayer) {
        [_audioPlayer stop];
    }
}

- (void)continousPlay {
    if (_audioPlayer && !_audioPlayer.isPlaying) {
        [_audioPlayer play];
    }
}

- (void)playAtTime:(NSTimeInterval)progress {
    if (_audioPlayer) {
        NSTimeInterval addTime = progress * _audioPlayer.duration;
        [_audioPlayer playAtTime:(_audioPlayer.deviceCurrentTime + addTime)];
        YDPannelINfo *info = [YDPannelINfo new];
        info.evaluateTotalTime(_audioPlayer.duration).evaluateCurrentTime(addTime);
        [[YDAudioControlPannelMgr shared] updateProgressViewWithInfo:info];
//         播放到指定的时间
        [self resetTimer];
    }
}

- (void)nextTrack:(CurrentPlayInfo)currentPlayInfo {
    if (_audioPlayer) {
        if (_media.mediaItemList.count <=1) {
            NSLog(@"当前可能只有一首歌");
            return;
        }
        
        NSInteger currentIndex = _media.currentIndex +1;
        if (currentIndex >= (_media.mediaItemList.count-1)) {
            NSLog(@"最后一首");
            return;
        }
        _media.currentIndex = currentIndex;
        YDMediaItem *currentItem = _media.mediaItemList[currentIndex];
        [self playWithUrlString:currentItem.mediaUrlStr];
        YDPannelINfo *info = [YDPannelINfo new];
        info.evaluateTitle(currentItem.title).evaluateCurrentTime(_audioPlayer.currentTime).evaluateTotalTime(_audioPlayer.duration).evaluatePlayingState(YES);
        !currentPlayInfo?:currentPlayInfo(info);
        return;
    }
    !currentPlayInfo?:currentPlayInfo(nil);
}

- (void)previousTrack:(CurrentPlayInfo)currentPlayInfo {
    if (_audioPlayer) {
        if (_media.mediaItemList.count <= 1 || _media.currentIndex == 0) {
            NSLog(@"当前只有一首歌或者是第一首");
            return;
        }
        _media.currentIndex -= 1;
        YDMediaItem *currentItem = _media.mediaItemList[_media.currentIndex];
        [self playWithUrlString:currentItem.mediaUrlStr];
        YDPannelINfo *info = [YDPannelINfo new];
        info.evaluateTitle(currentItem.title).evaluateCurrentTime(_audioPlayer.currentTime).evaluateTotalTime(_audioPlayer.duration).evaluatePlayingState(YES);
        !currentPlayInfo?:currentPlayInfo(info);
        return;
    }
    !currentPlayInfo?:currentPlayInfo(nil);

}

// isPlaying = yes ,or No
- (void)playOrPause:(CurrentPlayInfo)currentPlayInfo {
    if (_audioPlayer) {
        YDPannelINfo *info = [YDPannelINfo new];
        YDMediaItem *currentItem = _media.mediaItemList[_media.currentIndex];
        info.evaluateTitle(currentItem.title).evaluateCurrentTime(_audioPlayer.currentTime).evaluateTotalTime(_audioPlayer.duration);
        if (_audioPlayer.isPlaying) {
            [_audioPlayer pause];
            info.evaluatePlayingState(NO);
            !currentPlayInfo?:currentPlayInfo(info);
            return;
        }
        [_audioPlayer play];
        info.evaluatePlayingState(YES);
        !currentPlayInfo?:currentPlayInfo(info);
        return;
    }
    !currentPlayInfo?:currentPlayInfo(nil);
}


#pragma mark -- timer for audio player timer
- (void)resetTimer {
    [self destroyTimer];
    [self setTimer];
}

- (void)setTimer {
    _audioTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(onGetAudioPlayTimeTimer) userInfo:nil repeats:YES];
}

- (void)onGetAudioPlayTimeTimer {
    if (_audioPlayer.isPlaying) {
        YDPannelINfo *info = [YDPannelINfo new];
        info.evaluateCurrentTime(_audioPlayer.currentTime).evaluateTotalTime(_audioPlayer.duration);
        [[YDAudioControlPannelMgr shared] updateProgressViewWithInfo:info];
    }else{
        
    }
}

- (void)destroyTimer {
    if (!_audioPlayer) {
        return;
    }
    [_audioTimeTimer invalidate];
    _audioTimeTimer = nil;
}


#pragma mark -- lock and light screen 

- (void)_createRemoteCommandCenter {
    MPRemoteCommandCenter *cmdCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    [cmdCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"播放");
        _nowSecondTime = [[NSDate date] timeIntervalSince1970];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cmdCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"暂停播放");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cmdCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void)removeObserver{
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    [commandCenter.playCommand removeTarget:self];
    [commandCenter.pauseCommand removeTarget:self];
    [commandCenter.changePlaybackPositionCommand removeTarget:self];
}

- (void)_enablePlayBack {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    AudioSessionSetActive(YES);
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)_configureLockLightScreenWithMedia:(YDMediaItem *)mediaItem {
    [self _enablePlayBack];
    _nowSecondTime = [NSDate date].timeIntervalSince1970;
    NSLog(@"设置后台播放信息");
    
    YDMediaItem *currentItem = _media.mediaItemList[_media.currentIndex];
    NSMutableDictionary * songDict = @{}.mutableCopy;
    [songDict setObject:currentItem.title forKey:MPMediaItemPropertyTitle];
    [songDict setObject:currentItem.speaker forKey:MPMediaItemPropertyArtist];
    [songDict setObject:@(_audioPlayer.currentTime) forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [songDict setObject:@(_audioPlayer.duration) forKey:MPMediaItemPropertyPlaybackDuration];
    UIImage *image = [UIImage imageNamed:@"backgroundImage5.jpg"];
    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
    [songDict setObject:artwork forKey:MPMediaItemPropertyArtwork];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];

//    [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:media.imageUrlString] options:YYWebImageOptionShowNetworkActivity progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//        if (image) {
//            NSLog(@" block thread :%@",[NSThread currentThread]);
//            dispatch_main_async_safe(^{
//                NSLog(@"safe block thread :%@",[NSThread currentThread]);
//                MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
//                [songDict setObject:artwork forKey:MPMediaItemPropertyArtwork];
//                [songDict setObject:@(MPMediaTypeAnyAudio) forKey:MPMediaItemPropertyMediaType];
//                [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
//            });
//        }
//    }];

}


#pragma mark -- hover

- (void)initHoverBtn {
    if (_hoverBtn) {
        if (_hoverBtn.isHidden) {
            [_hoverBtn setHidden:NO];
        }
        return;
    }
    
    __weak typeof (self) wSelf = self;
    _hoverBtn = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-40, 200, 40, 40)];
    [_hoverBtn setBackgroundImage:[UIImage imageNamed:@"icon_audio_hover_btn"] forState:UIControlStateNormal];
    
    [_hoverBtn setLongPressBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  LongPress!!! ===");
        
    }];
    
    [_hoverBtn setTapBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  Tap!!! ===");
//        点击处理事件
        YDAudioControlPannelMgr *pannelMgr = [YDAudioControlPannelMgr shared];
        if (!pannelMgr.hasCreate) {
            CGRect rect = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 153);
            pannelMgr.createAControlPannel(rect).bgColor([UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.9]);
        }

        if (pannelMgr.isPannelHidden) {
            pannelMgr.hideHoverPannel(NO);
        }

        NSTimeInterval currentTime = wSelf.audioPlayer.currentTime;
        NSTimeInterval totalTime = wSelf.audioPlayer.duration;
        YDPannelINfo *info = [YDPannelINfo new];
        YDMediaItem *currentItem = wSelf.media.mediaItemList[wSelf.media.currentIndex];
        info.evaluateTitle(currentItem.title).evaluateCurrentTime(currentTime).evaluateTotalTime(totalTime).evaluatePlayingState(YES);
        [pannelMgr updateViewWithInfo:info];
    }];
    
}

- (void)setHiddenHoverBtn:(BOOL)flag {
    [_hoverBtn setHidden:flag];
}

@end
