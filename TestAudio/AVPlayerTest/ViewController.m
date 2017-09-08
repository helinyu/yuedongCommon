#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AKSpeechMgr.h"
#import "AKSpeechModel.h"

@interface ViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self comInit];
    [self baseInit];
}

- (void)baseInit {
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    NSLog(@"play back error :%@",error);
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [AVAudioSession sharedInstance].delegate = self;
    NSLog(@"active errro : %@",error);
    NSLog(@" audio error :%@",error);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInterruptClick:) name:AVAudioSessionInterruptionNotification object:nil];
    
}

- (void)onInterruptClick:(NSNotification *)noti {
    NSLog(@"noti :%@",noti);
}

- (void)comInit {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音乐" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);
    
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [timeBtn setTitle:@"时间播放" forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(onTimeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeBtn];
    timeBtn.frame = CGRectMake(100, 200, 100, 30);
    
    
    UIButton *speechBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [speechBtn setTitle:@"播放语音" forState:UIControlStateNormal];
    [speechBtn addTarget:self action:@selector(onPlaySpeechClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:speechBtn];
    speechBtn.frame = CGRectMake(100, 300, 100, 30);
}

- (void)onPlaySpeechClick {
    AKSpeechModel *item = [AKSpeechModel new];

    item.contentText = @"电脑音频播放器放不出声音怎么办？_百度知道站内的其它相关信息放器放不出声音怎么办？_百度知道站内的播放器放不出声音怎么办？_百度知道站内的其它相关信息放器放不出声音怎么办？_百度知道站内的播放器放不出声音怎么办？_百度知道站内的其它相关信息放器放不出声音怎么办？_百度知道站内的其如果您的iPhone、iPad 或iPod touch 扬声器无声音或声音失真- Apple 支持";
    item.rate = 0.2f;
    [[AKSpeechMgr shared] speechWithItem:item complete:^(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterance, NSRange characterRange, AKASpeechDelegateType type) {
        NSLog(@"languge : %@",[utterance.speechString substringWithRange:characterRange]);
    }];
}

- (void)onPlayClick {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"李宗盛 - 鬼迷心窍 - live" ofType:@"mp3"];
    _player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
    [_player play];
    AVPlayerItem *playerItem = _player.currentItem;
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
}



- (void)onTimeClick {
    [_player seekToTime:CMTimeMake(100, 1.0)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
