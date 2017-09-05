//
//  YDNSProgressViewController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/5.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDNSProgressViewController.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface YDNSProgressViewController ()

@property (nonatomic, strong) NSProgress *progress;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation YDNSProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //这个方法将创建任务进度管理对象 UnitCount是一个基于UI上的完整任务的单元数
    _progress = [NSProgress progressWithTotalUnitCount:10];
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTaskTimer) userInfo:nil repeats:YES];

    [_progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
//    fractionCompleted属性为0-1之间的浮点值，为任务的完成比例。
    
//  一个通过任务系统来监控，但是还是很不明显
    //向下分支出一个子任务 子任务进度总数为5个单元 即当子任务完成时 父progerss对象进度走5个单元《， 不是很明白
    [_progress becomeCurrentWithPendingUnitCount:5];
    NSLog(@"progress :%@",[NSProgress currentProgress]);
    [self subTaskOne];
    NSLog(@"progress :%@",[NSProgress currentProgress]);
    [_progress resignCurrent];
    
//    向下分出第2个任务
    [_progress becomeCurrentWithPendingUnitCount:5];
    [self subTaskOne];
    [_progress resignCurrent];
    
    [self comInit];

}

- (void)comInit {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音乐" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlayAudioClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 200, 120, 30);
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(100, 250, 200, 10)];
    [self.view addSubview:_progressView];

}



-(void)subTaskOne{
    //子任务总共有10个单元
    NSProgress * sub =[NSProgress progressWithTotalUnitCount:10];
    int i=0;
    while (i<10) {
        i++;
        sub.completedUnitCount++;
    }
}



-(void)onTaskTimer{
    //完成任务单元数+1

    if (_progress.completedUnitCount< _progress.totalUnitCount) {
        _progress.completedUnitCount +=1;
    }
    
}

static void *ProgressObserverContext = &ProgressObserverContext;

- (void)onPlayAudioClick {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"陈奕迅 - 富士山下.mp3" ofType:nil];
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:&error];
    if (error) {
        NSLog(@"error");
    }
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:10];
    [progress addObserver:self
               forKeyPath:NSStringFromSelector(@selector(fractionCompleted))
                  options:NSKeyValueObservingOptionInitial
                  context:ProgressObserverContext];
    [progress becomeCurrentWithPendingUnitCount:10];
    BOOL flag = [_audioPlayer play];
    NSLog(@"current progress :%@",[NSProgress currentProgress]);
    [progress resignCurrent];

    if (!flag) {
        NSLog(@"play error");
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == ProgressObserverContext)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSProgress *progress = object;
//            self.progress.progress = progress.fractionCompleted;
            self.progressView.progress = progress.fractionCompleted;
            NSLog(@"progress description :%@",progress.localizedDescription);
            NSLog(@"progress addiction description :%@",progress.localizedAdditionalDescription);
//            self.progressLabel.text = progress.localizedDescription;
//            self.progressAdditionalInfoLabel.text = progress.localizedAdditionalDescription;
        }];
    }
    else
    {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            NSLog(@"进度= %f",_progress.fractionCompleted);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
