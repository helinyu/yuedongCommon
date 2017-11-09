//
//  YDTest2ViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/9.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDTest2ViewController.h"
#import "Masonry.h"
#import "YDTest3ViewController.h"

@interface YDTest2ViewController ()

@end

@implementation YDTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    label.text = @"图片处理";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100.f);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(150);
    }];
    [btn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:confirmBtn];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(200);
    }];
    [confirmBtn addTarget:self action:@selector(onConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:otherBtn];
    [otherBtn setTitle:@"跳转到另外一个界面" forState:UIControlStateNormal];
    [otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(250);
    }];
    [otherBtn addTarget:self action:@selector(onOtherClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)onBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onConfirmClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onOtherClick:(id)sender {
    [self presentViewController:[YDTest3ViewController new] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
