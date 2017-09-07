//
//  ViewController.m
//  TestPureLayout
//
//  Created by Aka on 2017/9/7.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self comInit];
}

- (void)comInit {
    UIView *view0 = [UIView newAutoLayoutView];
    [self.view addSubview:view0];
    view0.backgroundColor = [UIColor redColor];
    [view0 autoCenterInSuperview];
    [view0 autoSetDimensionsToSize:CGSizeMake(100, 100)];
    
    UIView *view1 = [UIView newAutoLayoutView];
    [self.view addSubview:view1];
    view1.backgroundColor = [UIColor yellowColor];
    [view1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view1.superview withOffset:NSLayoutRelationEqual];
    [view1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:view1.superview withOffset:100.f];
    [view1 autoSetDimensionsToSize:CGSizeMake(100,100)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
