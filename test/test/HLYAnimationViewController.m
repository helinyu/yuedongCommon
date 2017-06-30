//
//  HLYAnimationViewController.m
//  test
//
//  Created by felix on 2017/6/23.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYAnimationViewController.h"
#import "HLYBaseTableViewCell.h"

@interface HLYAnimationViewController ()

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CALayer *animationLayer1;
@property (nonatomic, strong) CALayer *animationLayer2;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation HLYAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"uiview 上面的动画";
    
    _items = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",];
    
//    self.tableView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
//    [self.view addSubview:_tableView];
//    
//    [_tableView registerClass:[HLYBaseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HLYBaseTableViewCell class])];
    
    self.animationLayer1 = [CALayer new];
    self.animationLayer1 = [CALayer new];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor grayColor];
    
    [self.view.layer addSublayer:self.animationLayer1];
    [self.view.layer addSublayer:self.animationLayer2];

}

- (void)toAction:(UIButton *)sender {
    NSLog(@"动画1");
    _progressLayer = [CAShapeLayer new];
    [self.view.layer addSublayer:_progressLayer];
    self.view.layer.masksToBounds = YES;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0,self.view.center.y)];
    [linePath addLineToPoint:CGPointMake(CGRectGetWidth(self.view.bounds),self.view.center.y)];
    _progressLayer.path = linePath.CGPath;
    _progressLayer.lineWidth = 10.f;
    _progressLayer.strokeColor = [UIColor blueColor].CGColor;
    _progressLayer.lineCap = kCALineCapSquare;
    [_progressLayer removeAllAnimations];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = @0;
    pathAnimation.toValue = @1;
    pathAnimation.autoreverses = NO;
    pathAnimation.repeatCount = 1;
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];

}

- (void)animaitonWithLayer:(CALayer *)layer {
    
}

#pragma mark -- datasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HLYBaseTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
