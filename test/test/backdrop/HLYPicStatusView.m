//
//  HLYPicStatusView.m
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYPicStatusView.h"
#import "HLYBackdropModel.h"

@interface HLYPicStatusView ()

@property (nonatomic, strong) UIImageView *statusImageView;
//@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, strong)  CAShapeLayer *progressLayer;

@end

@implementation HLYPicStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit:frame];
    }
    return self;
}

- (void)comInit:(CGRect)frame {
    
    self.backgroundColor = [UIColor grayColor];
    
    _progressLayer = [CAShapeLayer new];
    [self.layer addSublayer:_progressLayer];
    self.layer.masksToBounds = YES;
     _progressLayer.lineWidth = 10.f;
    _progressLayer.strokeColor = [UIColor blueColor].CGColor;
    _progressLayer.lineCap = kCALineCapSquare;
//    [UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:0.9f];
//    _statusImageView = [UIImageView new];
//    CGFloat width = CGRectGetWidth(frame);
//    CGFloat height = CGRectGetHeight(frame);
//    _statusImageView.frame = CGRectMake((width-height)/2.f, 0, height, height);
//    [self addSubview:_statusImageView];
}

- (void)configureStatusWithItem:(HLYBackdropOnlineModel *)item {
    [_progressLayer removeAllAnimations];

    
    switch (item.type) {
        case HLYPicStatusTypeLoadNeed:
        {
            _progressLayer.hidden = YES;
        }
            break;
        case HLYPicStatusTypeLoading:
        {
            _progressLayer.hidden = NO;
            UIBezierPath *linePath = [UIBezierPath bezierPath];
            [linePath moveToPoint:CGPointMake(item.progress,CGRectGetHeight(self.bounds)/2)];
            [linePath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)*0.9,CGRectGetHeight(self.bounds)/2)];
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = 10;
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            pathAnimation.fromValue = @0;
            pathAnimation.toValue = @1;
            pathAnimation.autoreverses = NO;
            pathAnimation.repeatCount = 1;
            [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
            _progressLayer.path = linePath.CGPath;
        }
            break;
        case HLYPicStatusTypeLoaded:
        {
            _progressLayer.hidden = YES;
        }
            break;
        case HLYPicStatusTypeChoice:
        {
            _progressLayer.hidden = NO;
            _progressLayer.frame = self.bounds;
        }
            break;
        default:
            break;
    }
}

@end
