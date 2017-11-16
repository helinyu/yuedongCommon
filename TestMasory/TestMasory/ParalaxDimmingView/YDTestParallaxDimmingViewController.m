//
//  YDTestParallaxDimmingViewController.m
//  TestMasory
//
//  Created by Aka on 2017/11/16.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDTestParallaxDimmingViewController.h"

@interface YDTestParallaxDimmingViewController ()

@end

@implementation YDTestParallaxDimmingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


@end
