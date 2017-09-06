#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self comInit];
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
    
}

- (void)onPlayClick {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"李宗盛 - 鬼迷心窍 - live" ofType:@"mp3"];
    _player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
    [_player play];
    //    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    //    if (error) {
    //        NSLog(@"播放初始化失败");
    //    }
    
}

- (void)onTimeClick {
    [_player seekToTime:CMTimeMake(100, 1.0)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
