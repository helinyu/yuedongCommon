//
//  ViewController.m
//  VideoBackgroundModel
//
//  Created by Aka on 2017/8/21.
//  Copyright © 2017年 Aka. All rights reserved.
//
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController () {
    AVAudioPlayer *_player;
    BOOL _isPlayingNow;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    设置后台播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //    设置播放器
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"那些花儿" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player play];
    _isPlayingNow = YES;
    
    //后台播放显示信息设置
    [self setPlayingInfo];
}

#pragma mark - 接收方法的设置
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    if (event.type == UIEventTypeRemoteControl) {  //判断是否为远程控制
        switch (event.subtype) {
            case  UIEventSubtypeRemoteControlPlay:
                if (!_isPlayingNow) {
                    [_player play];
                }
                _isPlayingNow = !_isPlayingNow;
                break;
            case UIEventSubtypeRemoteControlPause:
                if (_isPlayingNow) {
                    [_player pause];
                }
                _isPlayingNow = !_isPlayingNow;
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"下一首");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"上一首 ");
                break;
            default:
                break;
        }
    }
}

- (void)setPlayingInfo {
    //    设置后台播放时显示的东西，例如歌曲名字，图片等
    //    <MediaPlayer/MediaPlayer.h>
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"pushu.jpg"]];
    
    NSDictionary *dic = @{MPMediaItemPropertyTitle:@"那些花儿",
                          MPMediaItemPropertyArtist:@"朴树",
                          MPMediaItemPropertyArtwork:artWork
                          };
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
}

- (void)viewDidAppear:(BOOL)animated {
    //    接受远程控制
    [self becomeFirstResponder];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (void)viewDidDisappear:(BOOL)animated {
    //    取消远程控制
    [self resignFirstResponder];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

