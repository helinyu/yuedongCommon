//
//  YDLayerViewController.m
//  TestCoreText
//
//  Created by mac on 14/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDLayerViewController.h"

@interface YDLayerViewController ()

@end

@implementation YDLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    [self.view.layer addSublayer:shapeLayer];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];

    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 10.f;
    shapeLayer.path = path.CGPath;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
