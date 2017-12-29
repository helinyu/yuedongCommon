//
//  YD4ViewController.m
//  HoverButton
//
//  Created by Aka on 2017/12/26.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YD4ViewController.h"

@interface YD4ViewController ()



@end

@implementation YD4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  [UIColor clearColor];
    self.view.alpha = 0.3f;
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(45, 50, 100, 100)];
    [self.view addSubview:v1];
    v1.layer.cornerRadius = 50.f;
//    [v1 setClipsToBounds:YES];
//    v1.layer.masksToBounds = YES;
    v1.backgroundColor = [UIColor yellowColor];
    v1.layer.shadowOffset = CGSizeMake(0, 10);
    v1.layer.shadowRadius = 2.f;
    v1.layer.shadowColor = [UIColor whiteColor].CGColor;
    v1.layer.shadowOpacity = 0.6;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
