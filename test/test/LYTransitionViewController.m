//
//  LYTransitionViewController.m
//  test
//
//  Created by felix on 2017/5/27.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "LYTransitionViewController.h"
#import "YDControllerAnimationMgr.h"
#import "LyToViewController.h"
#import "Masonry.h"


@interface LYTransitionViewController ()

@end

@implementation LYTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(act_toTranslation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

- (void)act_toTranslation:(UIButton *)sender {
    YDControllerAnimationMgr *mgr = [YDControllerAnimationMgr shareMgr];
    mgr.animStyle = ViewControllerTransitionStyleExpansion;
    LyToViewController *toVC = [LyToViewController new];
    toVC.transitioningDelegate = mgr;
    [self.navigationController pushViewController:toVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
