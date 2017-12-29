//
//  ViewController.m
//  testPhoto
//
//  Created by Aka on 2017/12/29.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"btn0" forState:UIControlStateNormal];
    [self.view addSubview:btn0];
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(80);
        make.width.height.mas_equalTo(100);
    }];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(btn0).offset(btn0);
        make.width.height.mas_equalTo(100);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
