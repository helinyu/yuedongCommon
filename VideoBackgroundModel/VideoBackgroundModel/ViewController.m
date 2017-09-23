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


@interface ViewController ()<AVAudioPlayerDelegate>
{
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
    [self comInit];
//    [self testQueue];
}

- (void)onBackGroundAudioClick:(id)sender {

}

- (void)onBackGroundAudioNoti:(NSNotification *)noti {
    NSLog(@"进入后台");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        for (NSInteger index =0; index < 100; index++) {
            NSLog(@"主线程");
            NSError *error = nil;
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
            if (error) {
                NSLog(@"mix erroro :%@",error);
            }else {
                NSLog(@"success");
            }
            [[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
            if (error) {
                NSLog(@" index :%ld ,error : %@",(long)index,error);
            }else{
                NSLog(@"success");
            }
//        }
        [self onAudioPlayClick:nil];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"恢复到前台");
//      BOOL result =  [[UIApplication sharedApplication] canBecomeFirstResponder];
//        NSLog(@"result :%d",result);
//        if (result) {
//            [[UIApplication sharedApplication] becomeFirstResponder];
////            [UIApplication sharedApplication] ope;
//        }
//    });
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBackGroundAudioNoti:) name:@"background" object:nil];
    
    UIButton *inactiveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [inactiveBtn setTitle:@"inactive" forState:UIControlStateNormal];
    [inactiveBtn addTarget:self action:@selector(onInactiveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inactiveBtn];
    inactiveBtn.frame = CGRectMake(150, 50, 100, 30);
    
    UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [activeBtn setTitle:@"active" forState:UIControlStateNormal];
    [activeBtn addTarget:self action:@selector(onActiveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activeBtn];
    activeBtn.frame = CGRectMake(0, 50, 100, 30);

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"audio play" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onAudioPlayClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);
    
    UIButton *playbackBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [playbackBtn setTitle:@"playback" forState:UIControlStateNormal];
    [playbackBtn addTarget:self action:@selector(onPlayBackClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbackBtn];
    playbackBtn.frame = CGRectMake(210, 150, 100, 30);
    
    UIButton *ambientBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [ambientBtn setTitle:@"ambient" forState:UIControlStateNormal];
    [ambientBtn addTarget:self action:@selector(onAmbientClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ambientBtn];
    ambientBtn.frame = CGRectMake(100, 150, 100, 30);
    
    UIButton *soloAmbientBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [soloAmbientBtn setTitle:@"soloambient" forState:UIControlStateNormal];
    [soloAmbientBtn addTarget:self action:@selector(onSoloAmbientClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soloAmbientBtn];
    soloAmbientBtn.frame = CGRectMake(210, 100, 100, 30);

    UIButton *addCMDBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addCMDBtn setTitle:@"MultiRoute" forState:UIControlStateNormal];
    [addCMDBtn addTarget:self action:@selector(onMultiRouteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addCMDBtn];
    addCMDBtn.frame = CGRectMake(0, 120, 98, 30);
    
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [recordBtn setTitle:@"record" forState:UIControlStateNormal];
    [recordBtn addTarget:self action:@selector(onRecordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordBtn];
    recordBtn.frame = CGRectMake(100, 200, 100, 30);

    UIButton *playAndRecordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [playAndRecordBtn setTitle:@"playAndRecord" forState:UIControlStateNormal];
    [playAndRecordBtn addTarget:self action:@selector(onPlayANdRecordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playAndRecordBtn];
    playAndRecordBtn.frame = CGRectMake(100, 250, 100, 30);

    UIButton *audioProcessingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [audioProcessingBtn setTitle:@"AudioProcessing" forState:UIControlStateNormal];
    [audioProcessingBtn addTarget:self action:@selector(onAudioProcessingClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:audioProcessingBtn];
    audioProcessingBtn.frame = CGRectMake(210, 250, 100, 30);
    
    UIButton *addcmdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addcmdBtn setTitle:@"add cmd" forState:UIControlStateNormal];
    [addcmdBtn addTarget:self action:@selector(onAddCMDClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addcmdBtn];
    addcmdBtn.frame = CGRectMake(0, 300, 100, 30);
    
    UIButton *removeCMDBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [removeCMDBtn setTitle:@"removeCmd" forState:UIControlStateNormal];
    [removeCMDBtn addTarget:self action:@selector(onRemoveCMDClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeCMDBtn];
    removeCMDBtn.frame = CGRectMake(110, 300, 100, 30);


    
//    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-200.f)];
//    _webView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:_webView];

}

- (void)onActiveClick:(id)sender {
    NSLog(@"active ");
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    if (error) {
        NSLog(@"recond error:%@",error);
    }else{
        NSLog(@"success");
    }
}

- (void)onAudioProcessingClick:(id)sender {
    NSLog(@"audio processing");
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAudioProcessing error:&error];
    if (error) {
        NSLog(@"recond error:%@",error);
    }else{
        NSLog(@"success");
    }
}

- (void)onPlayANdRecordClick:(id)sender {
    NSLog(@"play and record");
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
        NSLog(@"recond error:%@",error);
    }else{
        NSLog(@"success");
    }
}

- (void)onInactiveClick:(id)sender {
    NSLog(@"inactive ");
    [_player stop];
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    if (error) {
        NSLog(@"eror :%@",error);
    }else {
        NSLog(@"success ");
    }
}

- (void)onRecordClick:(id)sender {
    NSLog(@"record");
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:&error];
    if (error) {
        NSLog(@"recond error:%@",error);
    }else{
        NSLog(@"success");
    }
}

- (void)onAmbientClick:(UIButton *)sender {
    NSLog(@"Ambient");
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&error];
    if (error) {
        NSLog(@"error :%@",error);
    }else{
        NSLog(@"success");
    }
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.33.97:8000/movie/audio.html"]]];
}

- (void)onSoloAmbientClick:(id)sender {
    NSLog(@"SoloAmbient");
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:&error];
    if (error) {
        NSLog(@"eror ;%@",error);
    }
}

- (void)onAudioPlayClick:(id)sender {
    NSLog(@"play");
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"那些花儿" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _player.delegate = self;
    [_player play];
    _isPlayingNow = YES;
}

- (void)onPlayBackClick:(id)sender {
    NSLog(@"PlayBack");
    NSError *error = nil;
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
        NSLog(@"playback error :%@",error);
    }
}

- (void)onAddCMDClick:(UIButton *)sender {
    NSLog(@"add cmd");
    [self setPlayingInfo];
    [self _createRemoteCommandCenter];
}

- (void)onRemoveCMDClick:(id)sender {
    NSLog(@"remove cmd");
//    [[MPRemoteCommandCenter sharedCommandCenter].nextTrackCommand removeTarget:self];
//    [[MPRemoteCommandCenter sharedCommandCenter] performSelector:NSSelectorFromString(@"_handleRemoveCommand:") withObject:^void(){
//        NSLog(@"finished");
//    }];
//    [MPRemoteCommandCenter sharedCommandCenter];
//   NSInteger num = [(UIViewController *)self performSelector:NSSelectorFromString(@"testPerform:") withObject:@3];
//    NSLog(@"num :%ld",(long)num);
    [[MPRemoteCommandCenter sharedCommandCenter].nextTrackCommand removeTarget:self action:@selector(onNextclick:)];
    [[MPRemoteCommandCenter sharedCommandCenter].nextTrackCommand removeTarget:self];
    [[MPRemoteCommandCenter sharedCommandCenter] stopCommand];
}

- (NSInteger)testPerform:(NSNumber *)num {
    return num.integerValue;
}

- (void)onMultiRouteClick:(UIButton *)sender {
    NSLog(@"multi route");
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute error:&error];
    if (error) {
        NSLog(@"error :%@",error);
    }
}

- (void)_createRemoteCommandCenter {
    NSLog(@"add cmd center");
    if ([UIDevice currentDevice].systemVersion.floatValue >=7.1f) {
        MPRemoteCommandCenter *cmdCenter = [MPRemoteCommandCenter sharedCommandCenter];
        MPRemoteCommand *cmd = cmdCenter.nextTrackCommand;
        NSLog(@"cmd ;%@",cmd);
        [cmdCenter.nextTrackCommand addTarget:self action:@selector(onNextclick:)];

        //    <MediaPlayer/MediaPlayer.h>
//        MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"pushu.jpg"]];
        
//        NSDictionary *dic = @{MPMediaItemPropertyTitle:@"那些花儿",
//                              MPMediaItemPropertyArtist:@"朴树",
//                              MPMediaItemPropertyArtwork:artWork
//                              };
//        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nil];
//        Class remoteMediaVC = NSClassFromString(@"MPRemoteMediaPickerController");
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

#pragma mark -- audio player delegate

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"audioPlayerDidFinishPlaying");
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    NSLog(@"audioPlayerDecodeErrorDidOccur");
}

/* AVAudioPlayer INTERRUPTION NOTIFICATIONS ARE DEPRECATED - Use AVAudioSession instead. */

/* audioPlayerBeginInterruption: is called when the audio session has been interrupted while the player was playing. The player will have been paused. */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 8_0) {
    NSLog(@"audioPlayerBeginInterruption");

}

/* audioPlayerEndInterruption:withOptions: is called when the audio session interruption has ended and this player had been interrupted while playing. */
/* Currently the only flag is AVAudioSessionInterruptionFlags_ShouldResume. */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0) {
    NSLog(@"audioPlayerEndInterruption");

}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags NS_DEPRECATED_IOS(4_0, 6_0) {
    NSLog(@"audioPlayerEndInterruption");

}

/* audioPlayerEndInterruption: is called when the preferred method, audioPlayerEndInterruption:withFlags:, is not implemented. */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 6_0) {
    NSLog(@"audioPlayerEndInterruption");
}



@end

