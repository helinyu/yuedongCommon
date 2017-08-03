//
//  CircleExtentionAnimationViewController.m
//  test
//
//  Created by felix on 2017/5/12.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "CircleExtentionAnimationViewController.h"

@interface CircleExtentionAnimationViewController ()

@end

@implementation CircleExtentionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 50, 50);

    [self animateCicleScaleAndOpacity];
}
    
- (void)toAction:(UIButton *)sender {
}

- (void)animateCicleScaleAndOpacity {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue= @0.3;//开始的大小
    scaleAnimation.toValue= @50;//最后的大小 50 是下面的  spreadLayer.bounds = CGRectMake(0, 0, 10, 10); 大小的50倍数
    scaleAnimation.duration= 1;
    
    CAKeyframeAnimation* opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration=1;
    opacityAnimation.keyTimes = @[@0, @0.4 ,@0.9, @1];
    opacityAnimation.values=@[@0.05, @0.45, @0, @0];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:@"easeIn"];
    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
    animationGroup.duration=1;
    animationGroup.repeatCount = 1; //重复无限次
    animationGroup.timingFunction = defaultCurve;
    animationGroup.animations=@[scaleAnimation, opacityAnimation];
    
    CALayer *spreadLayer = [CALayer layer];
    spreadLayer.bounds = CGRectMake(0, 0, 10, 10);
    spreadLayer.cornerRadius = 5; //设置圆角变为圆形
    spreadLayer.position = CGPointMake(100, 200);
    spreadLayer.backgroundColor =  [UIColor whiteColor].CGColor;
    spreadLayer.masksToBounds=true;
    [self.view.layer insertSublayer:spreadLayer above:self.view.layer];
    
    //对层执行动画
    [spreadLayer addAnimation:animationGroup forKey:@"pulse"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
