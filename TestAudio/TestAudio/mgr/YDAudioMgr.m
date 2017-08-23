//
//  YDAudioMgr.m
//  Test_Audio
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDAudioMgr.h"
#import "wslAnalyzer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "YDOneLyricUnit.h"
#import <notify.h>

@interface YDAudioMgr ()
{
    id _playerTimeObserver;
    BOOL _isDragging;
    UIImage * _lastImage;//最后一次锁屏之后的歌词海报
}


@end

@implementation YDAudioMgr

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}
    
- (void)loadBase {
    [self _getLrcArray];
}
    
- (AVPlayer *)player {
    if (_player == nil) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"多幸运" ofType:@"mp3"];
        _player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:path]];
    }
    return _player;
}
    
//获得歌词数组
- (NSArray *)_getLrcArray{
    wslAnalyzer *  analyzer = [wslAnalyzer new];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"多幸运" ofType:@"txt"];
    self.lrcs =  [analyzer analyzerLrcBylrcString:[NSString  stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]];
    NSLog(@"self.lrcs count; %lu",(unsigned long)self.lrcs.count);
    return self.lrcs;
}
    
- (void)createRemoteCommandCenter {
    MPRemoteCommandCenter *cmdCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    MPRemoteCommand *pauseCmd = cmdCenter.pauseCommand;
    pauseCmd.enabled = YES;
//    pauseCmd.localizedTitle = @"暂停";
//    pauseCmd.localizedSubtitle = @"S";
    
    MPFeedbackCommand *likeCommand = cmdCenter.likeCommand;
    likeCommand.enabled = YES;
    likeCommand.localizedTitle = @"喜欢";
    [likeCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"喜欢");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    //添加不喜欢按钮，假装是“上一首”
    MPFeedbackCommand *dislikeCommand = cmdCenter.dislikeCommand;
    dislikeCommand.enabled = YES;
    dislikeCommand.localizedTitle = @"上一首";
    [dislikeCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"上一首");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    //标记
    MPFeedbackCommand *bookmarkCommand = cmdCenter.bookmarkCommand;
    bookmarkCommand.enabled = YES;
    bookmarkCommand.localizedTitle = @"标记";
    [bookmarkCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"标记");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    //    commandCenter.togglePlayPauseCommand 耳机线控的暂停/播放
    
    [cmdCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self.player pause];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [cmdCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self.player play];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    //    [commandCenter.previousTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
    //        NSLog(@"上一首");
    //        return MPRemoteCommandHandlerStatusSuccess;
    //    }];
    
    [cmdCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"下一首");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    //快进
    //    MPSkipIntervalCommand *skipBackwardIntervalCommand = commandCenter.skipForwardCommand;
    //    skipBackwardIntervalCommand.preferredIntervals = @[@(54)];
    //    skipBackwardIntervalCommand.enabled = YES;
    //    [skipBackwardIntervalCommand addTarget:self action:@selector(skipBackwardEvent:)];
    
    //在控制台拖动进度条调节进度（仿QQ音乐的效果）
    [cmdCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        CMTime totlaTime = self.player.currentItem.duration;
        MPChangePlaybackPositionCommandEvent * playbackPositionEvent = (MPChangePlaybackPositionCommandEvent *)event;
        [self.player seekToTime:CMTimeMake(totlaTime.value*playbackPositionEvent.positionTime/CMTimeGetSeconds(totlaTime), totlaTime.timescale) completionHandler:^(BOOL finished) {
        }];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void)dealloc {
    [self removeObserver];
}
    //移除观察者
- (void)removeObserver{
    
    [self.player removeTimeObserver:_playerTimeObserver];
    _playerTimeObserver = nil;
    
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    [commandCenter.likeCommand removeTarget:self];
    [commandCenter.dislikeCommand removeTarget:self];
    [commandCenter.bookmarkCommand removeTarget:self];
    [commandCenter.nextTrackCommand removeTarget:self];
    [commandCenter.skipForwardCommand removeTarget:self];
    [commandCenter.changePlaybackPositionCommand removeTarget:self];
}
    
//在具体的控制器或其它类中捕获处理远程控制事件,当远程控制事件发生时触发该方法, 该方法属于UIResponder类，iOS 7.1 之前经常用
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    NSLog(@"%ld",(long)event.type);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"songRemoteControlNotification" object:self userInfo:@{@"eventSubtype":@(event.subtype)}];
}
    
    //播放控制和监测
- (void)playControl{
    
    //后台播放音频设置,需要在Capabilities->Background Modes中勾选Audio,Airplay,and Picture in Picture
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    __weak typeof (self) wSelf = self;
    _playerTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(0.1*30, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {

        CGFloat currentTime = CMTimeGetSeconds(time);
    
        CMTime total = self.player.currentItem.duration;
        CGFloat totalTime = CMTimeGetSeconds(total);
        
        if (!_isDragging) {

            //歌词滚动显示
            for ( int i = (int)(self.lrcs.count - 1); i >= 0 ;i--) {
                YDOneLyricUnit * lrc = self.lrcs[i];
//                if (lrc.time < currentTime) {
//                    self.currentRow = i;
//                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: self.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//                    [self.tableView reloadData];
//                    [self.lockScreenTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: self. currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//                    [self.lockScreenTableView reloadData];
//                    break;
//                }
            }

        }

        //监听锁屏状态 lock=1则为锁屏状态
        uint64_t locked;
        __block int token = 0;
        notify_register_dispatch("com.apple.springboard.lockstate",&token,dispatch_get_main_queue(),^(int t){
            NSLog(@"noitify lock state");
        });
        notify_get_state(token, &locked);

        //监听屏幕点亮状态 screenLight = 1则为变暗关闭状态
        uint64_t screenLight;
        __block int lightToken = 0;
        notify_register_dispatch("com.apple.springboard.hasBlankedScreen",&lightToken,dispatch_get_main_queue(),^(int t){
            NSLog(@"lock the state");
        });
        notify_get_state(lightToken, &screenLight);

        BOOL isShowLyricsPoster = NO;
        // NSLog(@"screenLight=%llu locked=%llu",screenLight,locked);
        if (screenLight == 0 && locked == 1) {
            //点亮且锁屏时
            isShowLyricsPoster = YES;
        }else if(screenLight){
            return;
        }
        
//        展示锁屏歌曲信息，上面监听屏幕锁屏和点亮状态的目的是为了提高效率
        [self showLockScreenTotaltime:totalTime andCurrentTime:currentTime andLyricsPoster:isShowLyricsPoster];
    
    }];
}
    
    //展示锁屏歌曲信息：图片、歌词、进度、演唱者
- (void)showLockScreenTotaltime:(float)totalTime andCurrentTime:(float)currentTime andLyricsPoster:(BOOL)isShow{
    
    NSMutableDictionary * songDict = [[NSMutableDictionary alloc] init];
    //设置歌曲题目
    [songDict setObject:@"多幸运" forKey:MPMediaItemPropertyTitle];
    //设置歌手名
    [songDict setObject:@"韩安旭" forKey:MPMediaItemPropertyArtist];
    //设置专辑名
    [songDict setObject:@"专辑名" forKey:MPMediaItemPropertyAlbumTitle];
    //设置歌曲时长
    [songDict setObject:[NSNumber numberWithDouble:totalTime]  forKey:MPMediaItemPropertyPlaybackDuration];
    //设置已经播放时长
    [songDict setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];

    UIImage *lrcImage = [UIImage imageNamed:@"backgroundImage5.jpg"];
    //设置显示的海报图片
    [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:lrcImage]
                 forKey:MPMediaItemPropertyArtwork];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
    
}

@end
