//
//  VCPresentTransitionViewController.m
//  test
//
//  Created by felix on 2017/5/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "VCPresentTransitionViewController.h"
#import "VCToPresentedTransitionViewController.h"
#import "VCPresentTransitionAnimator.h"
#import "Masonry.h"

@interface VCPresentTransitionViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation VCPresentTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
   
}

#pragma mark --  UIViewControllerAnimatedTransitioning transitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [VCPresentTransitionAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [VCPresentTransitionAnimator new];
}

- (void)toAction:(UIButton *)sender {
    VCToPresentedTransitionViewController *toVC = [VCToPresentedTransitionViewController new];
    toVC.modalPresentationStyle = UIModalPresentationFullScreen;
    toVC.transitioningDelegate = self;
    [self presentViewController:toVC animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
