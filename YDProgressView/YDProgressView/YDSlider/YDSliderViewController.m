
//
//  YDSliderViewController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDSliderViewController.h"
#import "YDAudioControlPannelMgr.h"
#import "XHFloatWindow.h"
#import "YDMedia.h"
#import "YDBgMediaMgr.h"
#import <AVFoundation/AVFoundation.h>
#import "YDPannelINfo.h"

@interface YDSliderViewController ()

@property (nonatomic, strong) YDAudioControlPannelMgr *pannelMgr;
@property (nonatomic, strong) YDBgMediaMgr *audioMgr;

@end

@implementation YDSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];

    [self comInit];
}

- (void)comInit {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音频" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopBtn setTitle:@"停止播放" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(onStopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    stopBtn.frame = CGRectMake(100, 200, 100, 30);
}

- (void)onStopClick {
    [[YDBgMediaMgr shared] stop];
}

- (void)onPlayClick {
    YDBgMediaMgr *audioMgr = [YDBgMediaMgr shared];
    _audioMgr = audioMgr;
    NSArray *souces = @[
                        @"陈慧娴 - 与泪抱拥.mp3",
                        @"陈奕迅 - 富士山下.mp3",
                        @"李玉刚 - 刚好遇见你.mp3",
                      ];
    [self hoverBtnInit];
    YDMedia *media = [YDMedia medialWithTitle:souces[0] mediaUrl:souces[0] imageUrl:@"" artist:@"陈慧琳" currentTime:0 totalTime:0];
    [audioMgr playWithMedia:media];
    
}

- (void)hoverBtnInit {

    __weak typeof(self) wSelf = self;
    [XHFloatWindow xh_addWindowOnTarget:self onClick:^{
        YDAudioControlPannelMgr *mgr = [YDAudioControlPannelMgr shared];
        _pannelMgr =  mgr;
        if (!mgr.hasCreate) {
            CGRect rect = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 153);
            mgr.createAControlPannel(rect).bgColor([UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.9]);
        }

        if (mgr.isPannelHidden) {
            mgr.hideHoverPannel(NO);
        }

        NSTimeInterval currentTime = wSelf.audioMgr.audioPlayer.currentTime;
        NSTimeInterval totalTime = wSelf.audioMgr.audioPlayer.duration;
        YDPannelINfo *info = [YDPannelINfo new];
        info.evaluateTitle(@"标题").evaluateCurrentTime(currentTime).evaluateTotalTime(totalTime).evaluatePlayingState(YES);
        [wSelf.pannelMgr updateWithInfo:info];
    }];
    
//    xh_setBackgroundImage
    [XHFloatWindow xh_setBackgroundImage:@"icon_audio_hover_btn" forState:UIControlStateNormal];
    [XHFloatWindow xh_setBackgroundImage:@"icon_audio_hover_btn" forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
