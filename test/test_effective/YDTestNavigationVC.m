//
//  YDTestNavigationVC.m
//  test_effective
//
//  Created by Aka on 2017/11/9.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDTestNavigationVC.h"
#import "YDTest0ViewController.h"
#import "YDTest1ViewController.h"
#import "YDTest2ViewController.h"
#import "Masonry.h"

@interface YDTestNavigationVC ()

@end

@implementation YDTestNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *firstBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:firstBt];
    [firstBt setTitle:@"弹出页面" forState:UIControlStateNormal];
    [firstBt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [firstBt addTarget:self action:@selector(onTan:) forControlEvents:UIControlEventTouchUpInside];
    [firstBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100);
    }];
    
    YDTest0ViewController *vc0 = [YDTest0ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc0];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];

//    YDTest0ViewController *vc0 = [YDTest0ViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc0];
//    [self presentViewController:nav animated:NO completion:^{
//
//    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)onTan:(id)sender {
    YDTest0ViewController *vc0 = [YDTest0ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc0];
    [self presentViewController:nav animated:NO completion:^{

    }];
}

- (void)onAttach {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
