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
#import "NSObject+YDClass.h"


@interface ViewController () {
    AVAudioPlayer *_player;
    BOOL _isPlayingNow;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) MPMediaItem *medaiItem;

@end

static const char *queuStr= "string";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testClass];
    
//    [self comInit];
    
    [self testQueue];
}

- (void)testQueue {
    dispatch_queue_t queue1 = dispatch_queue_create(queuStr, DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create(queuStr, DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"qu1 :%@",queue1);
    NSLog(@"qu2 : %@",queue2);
    NSLog(@"quueu task :%@",queue1);
//    都是会创建这个队列的,看来注意队列是同一个队列

}

- (void)testClass {
    NSArray *methods = MethodsOfClass([MPRemoteCommandCenter class]);
    NSLog(@"methods : %@",methods);
}

- (void)comInit {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音频" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onAudioPlayClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopBtn setTitle:@"停止播放" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(onStopPlayClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    stopBtn.frame = CGRectMake(100, 150, 100, 30);
    
    UIButton *webBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [webBtn setTitle:@"网页加载" forState:UIControlStateNormal];
    [webBtn addTarget:self action:@selector(onWebClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:webBtn];
    webBtn.frame = CGRectMake(210, 100, 100, 30);
    
    UIButton *removeCMDBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [removeCMDBtn setTitle:@"删除center" forState:UIControlStateNormal];
    [removeCMDBtn addTarget:self action:@selector(onRemoveCMDCenterClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeCMDBtn];
    removeCMDBtn.frame = CGRectMake(210, 150, 100, 30);
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-200.f)];
    _webView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_webView];
    
}

- (void)onWebClick:(UIButton *)sender {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.33.97:8000/movie/audio.html"]]];
}

- (void)onStopPlayClick:(id)sender {
    NSLog(@"停止播放");
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [_player stop];
    _player = nil;
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    if (error) {
        NSLog(@"error");
    }
}

- (void)onAudioPlayClick:(id)sender {

//    NSError *cateforyError = nil;
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategory error:&cateforyError];
//    if (cateforyError) {
//        NSLog(@"erorro :%@",cateforyError);
//    }
//    
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    NSLog(@"开始播放");
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"那些花儿" ofType:@"mp3"] ];
//    _player = [[AVPlayer alloc] initWithURL:url];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player play];
    _isPlayingNow = YES;
    
    [self setPlayingInfo];
    [self _createRemoteCommandCenter];
}

- (void)onRemoveCMDCenterClick:(UIButton *)sender {
    MPRemoteCommandCenter *cmdCenter = [MPRemoteCommandCenter sharedCommandCenter];
//    [cmdCenter.playCommand removeTarget:self];
//    [cmdCenter.pauseCommand removeTarget:self];
    [cmdCenter.nextTrackCommand removeTarget:self];
//    cmdCenter.playCommand.enabled = NO;
//    cmdCenter.pauseCommand.enabled = NO;
//    cmdCenter.nextTrackCommand.enabled = NO;
}

- (void)_createRemoteCommandCenter {
    
    NSLog(@"cmd center");
    if ([UIDevice currentDevice].systemVersion.floatValue >=7.1f) {
        MPRemoteCommandCenter *cmdCenter = [MPRemoteCommandCenter sharedCommandCenter];
//        [_cmdCenter.playCommand addTarget:self action:@selector(onPlayCMDClick:)];
//        [_cmdCenter.pauseCommand addTarget:self action:@selector(onPauseCMDClick:)];
//        [cmdCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
//            NSLog(@"播放");
//            return MPRemoteCommandHandlerStatusSuccess;
//        }];
//        
//        [cmdCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
//            NSLog(@"暂停播放");
//            return MPRemoteCommandHandlerStatusSuccess;
//        }];
        
//      [cmdCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
//            NSLog(@"下一首");
//            return MPRemoteCommandHandlerStatusSuccess;
//        }];  
        
        [cmdCenter.nextTrackCommand addTarget:self action:@selector(onNextclick:)];

        
        //    <MediaPlayer/MediaPlayer.h>
//        MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"pushu.jpg"]];
        
//        NSDictionary *dic = @{MPMediaItemPropertyTitle:@"那些花儿",
//                              MPMediaItemPropertyArtist:@"朴树",
//                              MPMediaItemPropertyArtwork:artWork
//                              };
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nil];
        
        Class remoteMediaVC = NSClassFromString(@"MPRemoteMediaPickerController");

//        [cmdCenter.previousTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
//            NSLog(@"上一首");
//            return MPRemoteCommandHandlerStatusSuccess;
//        }];
        
//        [cmdCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
//            MPChangePlaybackPositionCommandEvent *positionEvent = (MPChangePlaybackPositionCommandEvent *)event;
//            NSTimeInterval positionTime = positionEvent.positionTime;
//            NSTimeInterval timeScale = 30.f;
//            NSLog(@"change position time ;%f",positionTime);
//            return MPRemoteCommandHandlerStatusSuccess;
//        }];
        
    }else{
        //        7.0 的需要进行处理
    }
}

- (void)onNextclick:(id)sender {
    NSLog(@"下一首");
}

- (void)onPlayCMDClick:(id)sender {
    NSLog(@"play");
}

- (void)onPauseCMDClick:(id)sender {
    NSLog(@"pause");
}

//#pragma mark - 接收方法的设置
//- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
//    if (event.type == UIEventTypeRemoteControl) {  //判断是否为远程控制
//        switch (event.subtype) {
//            case  UIEventSubtypeRemoteControlPlay:
//                if (!_isPlayingNow) {
//                    [_player play];
//                }
//                _isPlayingNow = !_isPlayingNow;
//                break;
//            case UIEventSubtypeRemoteControlPause:
//                if (_isPlayingNow) {
//                    [_player pause];
//                }
//                _isPlayingNow = !_isPlayingNow;
//                break;
//            case UIEventSubtypeRemoteControlNextTrack:
//                NSLog(@"下一首");
//                break;
//            case UIEventSubtypeRemoteControlPreviousTrack:
//                NSLog(@"上一首 ");
//                break;
//            default:
//                break;
//        }
//    }
//}

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
    //接受远程控制
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    //取消远程控制
    [self resignFirstResponder];
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

