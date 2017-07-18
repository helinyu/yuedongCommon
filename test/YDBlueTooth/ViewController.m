//
//  ViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "YDBlueToothMgr.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YDBlueToothMgr *blueToothMgr = [YDBlueToothMgr shared];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
