//
//  MementoViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MementoViewController.h"
#import "YDCustomView.h"
#import "YDCustomView+Private.h"

@interface MementoViewController ()

@end

@implementation MementoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    YDCustomView *view1 = [YDCustomView new];
    [view1 customviewLog];
    [view1 logCategory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
