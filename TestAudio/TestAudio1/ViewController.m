//
//  ViewController.m
//  TestAudio1
//
//  Created by Aka on 2017/8/29.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSInteger, YDTestType) {
    YDTestTypeNone = 0,
    YDTestTypeOne = 1,
};


@interface ViewController ()
//@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, assign) YDTestType *type;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonAudioConfigure];
    [self createComponent];
//    [self testEnum:4];
    
}

- (void)testEnum:(YDTestType)type {
    switch (type) {
        case YDTestTypeOne:
            NSLog(@"1");
            break;
        case YDTestTypeNone:
            NSLog(@"0");
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
            NSLog(@"3");
            break;
        default:
            NSLog(@"type : %d",type);
            break;
    }
}

- (void)createComponent {
    
    UIButton *nobtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nobtn setTitle:@"actice no" forState:UIControlStateNormal];
    [nobtn addTarget:self action:@selector(onActiveNO) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nobtn];
    nobtn.frame = CGRectMake(100, 40, 100, 30);
    
    UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [yesBtn setTitle:@"actice yes" forState:UIControlStateNormal];
    [yesBtn addTarget:self action:@selector(onActiveYES) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yesBtn];
    yesBtn.frame = CGRectMake(100, 100, 100, 30);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音乐" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 150, 100, 30);
}

- (void)commonAudioConfigure {
//    [AVAudioSession sharedInstance].delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInterrect:) name:AVAudioSessionInterruptionNotification object:nil];
}



- (void)onInterrect:(NSNotification *)noti {
    NSLog(@"被打断 : noti %@",noti);
}

- (void)onPlayClick {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"李宗盛 - 鬼迷心窍 - live" ofType:@"mp3"];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    _player.delegate = self;
    [_player play];
}

- (void)onActiveYES {
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    OSStatus status = AudioSessionSetActiveWithFlags(TRUE, kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation);
    NSLog(@"status : %@",status);
    BOOL result = [[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSLog(@"result : %d -- error : %@",result,error);
}

- (void)onActiveNO {
    [_player pause];
    NSError *error = nil;
    BOOL result = [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSLog(@"result :%d, error : %@",result, error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- delegate

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 8_0) {
    
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0) {
    
}

@end
