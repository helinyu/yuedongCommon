//
//  ViewController.m
//  AudioAttibute
//
//  Created by Aka on 2017/9/5.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self comInit];
}

- (void)comInit {
//
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音乐" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);
    
    UIButton *playATTimebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [playATTimebtn setTitle:@"playAtTime" forState:UIControlStateNormal];
    [playATTimebtn addTarget:self action:@selector(onPlayAtTimeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playATTimebtn];
    playATTimebtn.frame = CGRectMake(100, 100, 200, 30);

}

- (void)onPlayClick {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"李宗盛 - 鬼迷心窍 - live.mp3" ofType:nil];
    NSError *error = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    if (error) {
        NSLog(@"播放初始化失败");
    }
    BOOL flag = [_audioPlayer play];
    if (!flag) {
        NSLog(@"播放失败");
    }
}

- (void)onPlayAtTimeClick {
    if (!_audioPlayer) {
        NSLog(@"播放器还没有初始化");
        return;
    }
    BOOL flag = [_audioPlayer playAtTime:100];
    if (!flag) {
        NSLog(@"定时播放失败");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end