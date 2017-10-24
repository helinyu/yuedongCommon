//
//  YDTestYYLabelViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/23.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDTestYYLabelViewController.h"
#import "YYLabel.h"
#import "Masonry.h"

@interface YDTestYYLabelViewController ()

@end

@implementation YDTestYYLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    YYLabel *label = [YYLabel new];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor greenColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(100.f);
    }];
    
    label.text = @"人们的热闹";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
