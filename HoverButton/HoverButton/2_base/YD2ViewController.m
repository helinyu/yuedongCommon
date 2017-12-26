//
//  YD2ViewController.m
//  HoverButton
//
//  Created by Aka on 2017/8/31.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YD2ViewController.h"

@interface YD2ViewController ()

@property (nonatomic, assign) BOOL isOPen;

@end

@implementation YD2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"Snip20171225_1"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSecondPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 50, 200, 200);
}

- (void)onSecondPlay:(UIButton *)sender {
    NSLog(@"second play");
    
    if (!_isOPen) {
        [UIView animateWithDuration:1 animations:^{
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        self.isOPen = YES;
    }
    else {
        [UIView animateWithDuration:1 animations:^{
            sender.imageView.transform = CGAffineTransformIdentity;
        }];
        self.isOPen = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
