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

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, assign) YDTestType *type;
@property (nonatomic, assign) NSTimeInterval lastInterruptTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonAudioConfigure];
    [self createComponent];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInterrect:) name:AVAudioSessionInterruptionNotification object:nil];
}

- (void)onInterrect:(NSNotification *)noti {
    NSLog(@"被打断 : noti %@",noti);
    NSDictionary *contentDic = noti.userInfo;
    
//    AVAudioSessionInterruptionTypeKey = 1; 表示被打断
//    AVAudioSessionInterruptionOptionKey = 0;
//    AVAudioSessionInterruptionTypeKey = 0; //结束打断
//    表示打断终止,

    BOOL interruptBegin =[[contentDic objectForKey:AVAudioSessionInterruptionTypeKey] boolValue];
    if (interruptBegin == YES) {
        _lastInterruptTime = _player.currentTime;
        NSLog(@"device interrupt play time : %f",_player.deviceCurrentTime);
    }else{
//        interrupt End
        AVAudioSessionInterruptionOptions interruptionOptions = (AVAudioSessionInterruptionOptions)[contentDic objectForKey:AVAudioSessionInterruptionOptionKey];
        if (AVAudioSessionInterruptionOptionShouldResume == interruptionOptions) {
//            处理外面暂停的音频
        }else{
            [[AVAudioSession sharedInstance] setActive:YES error:nil];
            NSTimeInterval time = _lastInterruptTime + _player.deviceCurrentTime;
            [_player playAtTime:time];
        }
    }
}

- (void)onPlayClick {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"李宗盛 - 鬼迷心窍 - live" ofType:@"mp3"];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
//    _player.delegate = self;
    NSLog(@"device play time : %f",_player.deviceCurrentTime);
    [_player play];
}

- (void)onActiveYES {
    NSError *error = nil;
//    要实现打断，必定是不能够混合语音了
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    OSStatus status = AudioSessionSetActiveWithFlags(TRUE, kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation);
    NSLog(@"status : %d",(int)status);
    BOOL result = [[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSLog(@"result : %d -- error : %@",result,error);
}

- (void)onActiveNO {
    [_player pause];
    NSError *error = nil;
    BOOL result = [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSLog(@"result :%d, error : %@",result, error);
}

#pragma mark -- delegate

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
//    记录播放的时间等等信息 （主要是时间）
    NSLog(@"audioPlayerBeginInterruption");
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    NSLog(@"audioPlayerEndInterruption:withOptions: flags : %lu",(unsigned long)flags);
    if (flags) {
//         外面的应用要重启
    }else{
//        [_player playAtTime:_lastInterruptTime];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
