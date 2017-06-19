//
//  HLYShadownViewController.m
//  test
//
//  Created by felix on 2017/6/8.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYShadownViewController.h"

@interface HLYShadownViewController ()

@end

@implementation HLYShadownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *test1View = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:test1View];
    test1View.backgroundColor = [UIColor yellowColor];
    test1View.layer.shadowColor = [UIColor blackColor].CGColor;
    test1View.layer.shadowOpacity = 1.0f;
    test1View.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    test1View.layer.shadowRadius = 4.f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
