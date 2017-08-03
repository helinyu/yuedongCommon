//
//  CircleAnimationViewController.m
//  test
//
//  Created by felix on 2017/5/22.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "CircleAnimationViewController.h"
#import "Masonry.h"

@interface CircleAnimationViewController ()

@property (nonatomic, weak) UILabel *countLabel;

//动画字体模糊出现了的问题，是经过设置足够大的大小，然后再进行缩小；

@end

@implementation CircleAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"动画" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 80, 80);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"动画2" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(200, 100, 80, 80);
    btn2.backgroundColor = [UIColor blueColor];
    [btn2 addTarget:self action:@selector(toAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    self.countLabel = label;
    self.countLabel.backgroundColor = [UIColor yellowColor];
    self.countLabel.frame = CGRectMake(0, 0, 206.6, 406.6);
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    self.countLabel.text = @"3";
    self.countLabel.font = [UIFont systemFontOfSize:200];
    [self.countLabel sizeToFit];
    self.countLabel.alpha = 0.0f;
}

- (void)toAction:(UIButton *)sender {
    
    CAKeyframeAnimation* opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.xy"];
    opacityAnimation.duration= 1;
    opacityAnimation.keyTimes = @[@0,@0.5, @1];
    opacityAnimation.values=@[@1,@0.1,@1];
    
    CAKeyframeAnimation *fontAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transfrom.font"];
    fontAnimation.duration= 1;
    fontAnimation.keyTimes = @[@0,@0.5, @1];
    fontAnimation.values=@[@7,@70,@7];
    
    CALayer *spreadLayer = self.countLabel.layer;
    spreadLayer.position = self.view.center;
    spreadLayer.masksToBounds=true;

    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
    animationGroup.duration= 1;
    animationGroup.repeatCount = 1; //重复1次
    animationGroup.animations=@[fontAnimation, opacityAnimation];
    //对层执行动画
    [spreadLayer addAnimation:animationGroup forKey:@"pulse"];
}

- (void)toAction2:(UIButton *) sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.countLabel.transform = CGAffineTransformScale(self.countLabel.transform, 1.0/3, 1.0/3);
        self.countLabel.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.countLabel.transform = CGAffineTransformScale(self.countLabel.transform, 3.0, 3.0);
            self.countLabel.alpha = 1.0f;
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
