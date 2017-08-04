//
//  LYThirdAnimationViewController.m
//  test
//
//  Created by felix on 2017/5/27.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "LYThirdAnimationViewController.h"
#import "LYThirdToViewController.h"
#import "LYThirdFromViewController.h"

@interface LYThirdAnimationViewController ()

@property (nonatomic, strong) LYThirdToViewController *toVC;
@property (nonatomic, strong) LYThirdFromViewController *fromVC;

@end

@implementation LYThirdAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _fromVC = [LYThirdFromViewController new];
    _toVC = [LYThirdToViewController new];
    
    self.view.backgroundColor = [UIColor purpleColor];

}

- (void)toAction:(UIButton *)sender {
    [self addChildViewController:_toVC];
    [_fromVC willMoveToParentViewController:nil];
    [self.view addSubview:_toVC.view];
    
    __weak id weakSelf = self;
    [self transitionFromViewController:_fromVC
                      toViewController:_toVC duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                _fromVC.view.alpha = 0.0f;
                                _toVC.view.alpha = 1.0f;
                            }
                            completion:^(BOOL finished) {
//                                [_fromVC.view removeFromSuperView];
                                [_fromVC removeFromParentViewController];
                                [_toVC didMoveToParentViewController:weakSelf];
                            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
