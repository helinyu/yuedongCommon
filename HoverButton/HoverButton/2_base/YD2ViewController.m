//
//  YD2ViewController.m
//  HoverButton
//
//  Created by Aka on 2017/8/31.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YD2ViewController.h"

@interface YD2ViewController ()

@end

@implementation YD2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"第二个页面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSecondPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 300, 100);
    
}

- (void)onSecondPlay {
    NSLog(@"second play");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
