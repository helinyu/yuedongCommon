//
//  HLYCaShapeLayerViewController.m
//  test
//
//  Created by felix on 2017/5/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYCaShapeLayerViewController.h"
#import "Masonry.h"

@interface HLYCaShapeLayerViewController ()

@property (nonatomic, weak) UIButton *testBtn;
@property (nonatomic, weak) CAShapeLayer *line;
@property (nonatomic, strong) UIView *lineBgView;

@end

@implementation HLYCaShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"绘画动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(100);
    }];
    self.testBtn = btn;
    
}

- (void)toAction:(UIButton *)sender {
    [self testCALayer];
}

- (void)testCALayer {

    self.lineBgView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 20, 200)];
    [self.view addSubview:self.lineBgView];
    
    self.lineBgView.backgroundColor = [UIColor yellowColor];
    self.lineBgView.layer.masksToBounds = YES;
    self.view.layer.masksToBounds = YES;
    
    CAShapeLayer *line = [CAShapeLayer new];
    [self.lineBgView.layer addSublayer:line];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(10,0)];
    [linePath addLineToPoint:CGPointMake(10,100)];
    line.path = linePath.CGPath;
    line.lineWidth = 10;
//    line.fillColor = [UIColor yellowColor].CGColor;
    line.strokeColor = [UIColor greenColor].CGColor;
    line.lineCap = kCALineCapRound;
    [line removeAllAnimations];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = @0;
    pathAnimation.toValue = @1;
    pathAnimation.autoreverses = NO;
    pathAnimation.repeatCount = 1;
    [line addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    self.line = line;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    if (self.line) {
        [self.line removeFromSuperlayer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
