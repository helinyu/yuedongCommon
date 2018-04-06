//
//  CoordinatingViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CoordinatingViewController.h"

@interface CoordinatingViewController ()

@end

@implementation CoordinatingViewController

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static CoordinatingViewController* sigle = nil;
    dispatch_once(&onceToken, ^{
        CoordinatingViewController *vc = [CoordinatingViewController new];
        sigle = vc;
    });
    return sigle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
