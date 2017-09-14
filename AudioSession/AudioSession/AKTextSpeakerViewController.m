//
//  AKTextSpeakerViewController.m
//  AudioSession
//
//  Created by Aka on 2017/9/13.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "AKTextSpeakerViewController.h"
#import "AKSpeechMgr.h"
#import "AKSpeechModel.h"
//#import "MSLog.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioSession.h>

@interface AKTextSpeakerViewController ()

@end

@implementation AKTextSpeakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self comInit];
    
}

- (void)comInit {
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [playBtn setTitle:@"播放语音" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(onSpeakerClick:) forControlEvents:UIControlEventTouchUpInside];
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
    AudioSessionSetActiveWithFlags(NO, kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation);
    NSError *error = nil;
    BOOL result = [[AVAudioSession sharedInstance] setActive:NO error:&error];
    if (error) {
        NSLog(@"error set active of audio session : %@",error);
    }
}

- (void)onSpeakerClick:(UIButton *)sender {
    AKSpeechModel *item = [AKSpeechModel new];
    item.contentText = @"先说说iOS应用程序5个状态：停止运行-应用程序已经终止，或者还未启动。 ... 着当应用退至后台，其后台运行仅能持续10分钟便会转至休眠状态。iOS ... 不过拥有了这个接口后，这情况将不复存在，以后推送将能够直接启动后台任务";
    [[AKSpeechMgr shared] speechWithItem:item complete:^(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterance, NSRange characterRange, AKASpeechDelegateType type) {
//        NSLog(@"text :%@",[utterance.speechString substringWithRange:characterRange]);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
