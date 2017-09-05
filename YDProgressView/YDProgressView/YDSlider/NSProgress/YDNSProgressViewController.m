//
//  YDNSProgressViewController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/5.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDNSProgressViewController.h"
#import <Foundation/Foundation.h>

@interface YDNSProgressViewController ()

@property (nonatomic, strong) NSProgress *progress;

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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"进度= %f",_progress.fractionCompleted);
}

-(void)onTaskTimer{
    //完成任务单元数+1

    if (_progress.completedUnitCount< _progress.totalUnitCount) {
        _progress.completedUnitCount +=1;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
