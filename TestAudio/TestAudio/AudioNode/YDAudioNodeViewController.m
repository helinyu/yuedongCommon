//
//  YDAudioNodeViewController.m
//  TestAudio
//
//  Created by Aka on 2017/8/24.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDAudioNodeViewController.h"
#import "YDAudioMgr.h"

@interface YDAudioNodeViewController ()

@property (nonatomic, strong) YDAudioMgr *audioMgr;


@end

@implementation YDAudioNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatComponents];

}

- (void)creatComponents {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音乐" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlayClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(10, 10, 100, 30);
    
    
}


- (void)onPlayClick:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
