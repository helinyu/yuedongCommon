//
//  HLYShapeLayerViewController.m
//  test
//
//  Created by Aka on 2017/7/5.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYShapeLayerViewController.h"

@interface HLYShapeLayerViewController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CALayer *baseLayer;

@property (nonatomic, strong) UIView *baseView;

@end

@implementation HLYShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _shapeLayer = [CAShapeLayer new];
    _shapeLayer.frame = CGRectZero;
    _shapeLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:_shapeLayer];
    
    _baseLayer = [CALayer new];
    _baseLayer.frame = CGRectZero;
    _baseLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:_baseLayer];
    
    _baseView = [UIView new];
    _baseView.frame = CGRectZero;
    _baseView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_baseView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 200, 50, 50);
    btn.backgroundColor = [UIColor blackColor];

}


- (void)toAction:(UIButton *)sender {
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _shapeLayer.frame = CGRectMake(0, 0, 200, 200);
//        _baseLayer.frame =CGRectMake(0, 0, 200, 200);
//    _baseView.frame = CGRectMake(0, 0, 200, 200);
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
