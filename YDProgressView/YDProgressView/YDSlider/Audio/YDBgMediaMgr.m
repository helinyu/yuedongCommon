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
#import "XHFloatWindow.h"
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

@end

@implementation YDBgMediaMgr

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
    [self playWithUrlString:media.mediaUrlString];
    [self _configureLockLightScreenWithMedia:media];
    [self _createRemoteCommandCenter];
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

- (void)nextTrack:(CurrentPlayInfo)currentPlayInfo {
    if (_audioPlayer) {
        if (_media.mediaUrlStrings.count <=0) {
            NSLog(@"当前可能只有一首歌");
            return;
        }
        NSInteger currentIndex = _media.index +1;
        if (_media.index >= (_media.mediaUrlStrings.count-1)) {
            NSLog(@"最后一首");
            return;
        }
        
        _media.index = currentIndex;
        [self playWithUrlString:_media.mediaUrlStrings[currentIndex]];
        YDPannelINfo *info = [YDPannelINfo new];
        info.evaluateTitle(_media.title).evaluateCurrentTime(_media.currentTime).evaluateTotalTime(_audioPlayer.duration).evaluatePlayingState(YES);
        !currentPlayInfo?:currentPlayInfo(info);
        return;
    }
    !currentPlayInfo?:currentPlayInfo(nil);
}

- (void)previousTrack:(CurrentPlayInfo)currentPlayInfo {
    if (_audioPlayer) {
        if (_media.mediaUrlStrings.count <= 1 || _media.index == 0) {
            NSLog(@"当前只有一首歌或者是第一手");
            return;
        }
        _media.index -= 1;
        [self playWithUrlString:_media.mediaUrlStrings[_media.index]];
        YDPannelINfo *info = [YDPannelINfo new];
        info.evaluateTitle(_media.title).evaluateCurrentTime(_media.currentTime).evaluateTotalTime(_audioPlayer.duration).evaluatePlayingState(YES);
        !currentPlayInfo?:currentPlayInfo(info);
        return;
    }
    !currentPlayInfo?:currentPlayInfo(nil);

}

// isPlaying = yes ,or No
- (void)playOrPause:(CurrentPlayInfo)currentPlayInfo {
    if (_audioPlayer) {
        YDPannelINfo *info = [YDPannelINfo new];
        info.evaluateTitle(_media.title).evaluateCurrentTime(_media.currentTime).evaluateTotalTime(_audioPlayer.duration);
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

- (void)_createRemoteCommandCenter {
    MPRemoteCommandCenter *cmdCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    __weak typeof (self) wSelf = self;
    [cmdCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"播放");
        _nowSecondTime = [[NSDate date] timeIntervalSince1970];
        [wSelf _configureLockLightScreenWithMedia:_media];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cmdCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"暂停播放");
        NSTimeInterval nowSecondTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval lastTime = _media.currentTime;
        _media.currentTime = (nowSecondTime - _nowSecondTime) + lastTime;
        [wSelf _configureLockLightScreenWithMedia:_media];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cmdCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void)dealloc {
    [self removeObserver];
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

- (void)_configureLockLightScreenWithMedia:(YDMedia *)media {
    [self _enablePlayBack];
    _media = media;
    _nowSecondTime = [NSDate date].timeIntervalSince1970;
    NSLog(@"设置后台播放信息");
    
    NSMutableDictionary * songDict = @{}.mutableCopy;
    [songDict setObject:media.title forKey:MPMediaItemPropertyTitle];
    [songDict setObject:media.artist forKey:MPMediaItemPropertyArtist];
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

@end
