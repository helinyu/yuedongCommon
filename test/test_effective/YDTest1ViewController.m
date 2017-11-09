//
//  YDTest1ViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/9.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDTest1ViewController.h"
#import "Masonry.h"
#import "YDTest2ViewController.h"

@interface YDTest1ViewController ()

@end

@implementation YDTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    label.text = @"预览图片";
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
    
    self.view.backgroundColor = [UIColor purpleColor];
}

- (void)onBack:(id)sender {
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onConfirmClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)onOtherClick:(id)sender {
    YDTest2ViewController *vc2 = [YDTest2ViewController new];
//    [self.navigationController pushViewController:vc2 animated:NO];
    [self presentViewController:vc2 animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 有关的内容如何进行处理？
 present 的内容中有navigationcontroller，这里面就是可以进行push等等操作
 但是某个dismiss的时候，就会返回到present出现的地方了；
 */

@end
