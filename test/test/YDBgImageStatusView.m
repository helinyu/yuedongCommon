//
//  HLYPicStatusView.m
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDBgImageStatusView.h"

@interface YDBgImageStatusView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation YDBgImageStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit:frame];
    }
    return self;
}

- (void)comInit:(CGRect)frame {
    
    self.backgroundColor = [UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:0.9f];
    
    _progressLayer = [CAShapeLayer new];
//    _progressLayer.frame = CGRectMake(0, 0, 2.f, self.bounds.size.height);
    [self.layer addSublayer:_progressLayer];
    _progressLayer.backgroundColor = [UIColor greenColor].CGColor;

}

- (void)configureStatusWithType:(NSInteger)type {
    
    switch (type) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
//            _progressLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)*item.progress, self.bounds.size.height);
            NSLog(@"center.y is : %f",self.center.y);
            NSLog(@"half of hegiht : %f",self.bounds.size.height/2);
            UIBezierPath *linePath = [UIBezierPath bezierPath];
            [linePath moveToPoint:CGPointMake(0, self.bounds.size.height/2)];
            [linePath addLineToPoint:CGPointMake(self.bounds.size.width *0.8, self.bounds.size.height/2)];
            _progressLayer.path = linePath.CGPath;
            _progressLayer.lineWidth = self.bounds.size.height;
            _progressLayer.strokeColor = [UIColor greenColor].CGColor;
            _progressLayer.lineCap = kCALineCapSquare;
            [_progressLayer removeAllAnimations];
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = 10.f;
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            pathAnimation.fromValue = @0;
            pathAnimation.toValue = @1;
            pathAnimation.autoreverses = NO;
            pathAnimation.repeatCount = 1;
            [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
            self.layer.masksToBounds = YES;
//            _progressLayer.frame = CGRectMake(0, 0, 0.1f, 20);
//            UIBezierPath *linePath = [UIBezierPath bezierPath];
//            [linePath moveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds)/2)];
//            [linePath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds)/2)];
//            _progressLayer.path = linePath.CGPath;
//            _progressLayer.lineWidth = self.bounds.size.height;
//            _progressLayer.strokeColor = [UIColor blueColor].CGColor;
//            _progressLayer.lineCap = kCALineCapSquare;
//            [_progressLayer removeAllAnimations];
//            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//            pathAnimation.duration = 4;
//            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//            pathAnimation.fromValue = @0;
//            pathAnimation.toValue = @1;
//            pathAnimation.autoreverses = NO;
//            pathAnimation.repeatCount = 1;
//            [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        }
            break;
        default:
            break;
    }
}

@end
