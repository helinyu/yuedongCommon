//
//  HLY8ViewController.m
//  test
//
//  Created by felix on 2017/6/25.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLY8ViewController.h"
#import "EOCPerson.h"
#import <StoreKit/StoreKit.h>

@interface HLY8ViewController ()

@end

@implementation HLY8ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"评论" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor redColor]];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor yellowColor];
    btn.frame = CGRectMake(100, 100, 100, 100);
}

- (void)toAction:(UIButton *)sender {
    [SKStoreReviewController requestReview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
