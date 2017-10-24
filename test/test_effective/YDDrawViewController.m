//
//  YDDrawViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/23.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDDrawViewController.h"
#import "YDDrawView.h"

@interface YDDrawViewController ()

@end

@implementation YDDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    YDDrawView *drawView = [YDDrawView new];
    [self.view addSubview:drawView];
    drawView.backgroundColor = [UIColor greenColor];
    drawView.frame = CGRectMake(100, 100, 200, 200);
}


@end
