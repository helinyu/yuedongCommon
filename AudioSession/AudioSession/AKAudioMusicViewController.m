//
//  AKAudioMusicViewController.m
//  AudioSession
//
//  Created by Aka on 2017/9/14.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "AKAudioMusicViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AKAudioMusicViewController ()

@property (nonatomic, strong) AVAudioPlayer *player;
//@property (nonatomic, strong) AVPlayer *player;
@end

@implementation AKAudioMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self comInit];

}

- (void)comInit {
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [playBtn setTitle:@"播放(长)音频" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(onAudioMusicClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    playBtn.frame = CGRectMake(100, 100, 200, 30);
    
    UIButton *openSessionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [openSessionBtn setTitle:@"open audiosession" forState:UIControlStateNormal];
    [openSessionBtn addTarget:self action:@selector(onOpenSessionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openSessionBtn];
    openSessionBtn.frame = CGRectMake(100, 200, 200, 30);
    
    UIButton *closeSessionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeSessionBtn setTitle:@"close audiosession" forState:UIControlStateNormal];
    [closeSessionBtn addTarget:self action:@selector(onCloseSessionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeSessionBtn];
    closeSessionBtn.frame = CGRectMake(100, 300, 200, 30);
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopBtn setTitle:@"停止播放" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(onStopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    stopBtn.frame = CGRectMake(100, 400, 100, 30);

}

#pragma mark -- custom btn method

- (void)onOpenSessionClick:(UIButton *)sender {
    NSLog(@"开启音频回话");
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    BOOL flag = [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (!flag) {
        NSLog(@"error : %@",error);
    }
}

- (void)onCloseSessionClick:(UIButton *)sender {
    NSLog(@"关闭音频回话");
//    AudioSessionSetActiveWithFlags(NO, kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation);
    NSError *error = nil;
    BOOL result = [[AVAudioSession sharedInstance] setActive:NO error:&error];
    if (error) {
        NSLog(@"error set active of audio session : %@",error);
    }
}

- (void)onAudioMusicClick:(UIButton *)sender {
    NSLog(@"播放音频");
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"那些花儿" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    _player = [[AVPlayer alloc] initWithURL:url];
    [_player play];
}

- (void)onStopClick:(UIButton *)sender {
    NSLog(@"停止播放");
//    [_player pause]; // 这个过程应该还是有缓存的
    [_player stop]; // 上面两个是audioPlayer，
  
//    [_player pause];  // avplayer的内容
}

@end
