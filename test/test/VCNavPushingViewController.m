//
//  VCNavPushingViewController.m
//  test
//
//  Created by felix on 2017/5/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "VCNavPushingViewController.h"
#import "VCNavPushedViewController.h"
#import "Masonry.h"
#import "VCNavTransitionAnimator.h"
#import "YDBaseTransitionAnimator.h"

@interface VCNavPushingViewController ()<UINavigationControllerDelegate>
@end

@implementation VCNavPushingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationController.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)toAction:(UIButton*)sender {
    VCNavPushedViewController *npVC = [VCNavPushedViewController new];
    npVC.navigationController.delegate = self;
    [self.navigationController pushViewController:npVC animated:true];
}


// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    if(operation == UINavigationControllerOperationPush) {
        return [VCNavTransitionAnimator new];
    }else{
        return [YDBaseTransitionAnimator new];
    }
}


@end
