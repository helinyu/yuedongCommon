//
//  AnimationCollectionViewCell.m
//  test
//
//  Created by Aka on 2017/7/4.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "AnimationCollectionViewCell.h"
#import "YDBgImageStatusView.h"

@interface AnimationCollectionViewCell ()

@property (nonatomic, strong) YDBgImageStatusView *imageStatusView;

@end

static const CGFloat progressPercentH = 2/11.f;
static const CGFloat progressPercentY= 9/11.f;

@implementation AnimationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
    }
    return self;
}

- (void)comInit {
    _shapeLayer = [CAShapeLayer new];
    [self.contentView.layer addSublayer:_shapeLayer];
    _shapeLayer.backgroundColor = [UIColor greenColor].CGColor;
    _shapeLayer.frame = CGRectMake(0, 0, 0.1f, 20);
    
    _titleLB = [UILabel new];
    [self addSubview:_titleLB];
    _titleLB.frame = CGRectMake(0, 20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    if (!_imageStatusView) {
        _imageStatusView = [[YDBgImageStatusView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)*progressPercentY, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)*progressPercentH)];
        [self.contentView addSubview:_imageStatusView];
    }

}

- (void)configureAnimationWithIem:(AnimationCollectionModel *)item {
    
    [_imageStatusView configureStatusWithType:item.type];;
//    switch (item.type) {
//        case 0:
//        {
//            _shapeLayer.frame = CGRectMake(0, 20, 0.1f, 20);
//            
//        }
//            break;
//        case 1:
//        {
//            _shapeLayer.frame = CGRectMake(0, 20, 0.1f, 20);
//            UIBezierPath *linePath = [UIBezierPath bezierPath];
//            [linePath moveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds)/2)];
//            [linePath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds)/2)];
//            _shapeLayer.path = linePath.CGPath;
//            _shapeLayer.lineWidth = 5.f;
//            _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
//            _shapeLayer.lineCap = kCALineCapSquare;
//            [_shapeLayer removeAllAnimations];
//            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//            pathAnimation.duration = 4;
//            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//            pathAnimation.fromValue = @0;
//            pathAnimation.toValue = @1;
//            pathAnimation.autoreverses = NO;
//            pathAnimation.repeatCount = 1;
//            [_shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
//        }
//            break;
//        default:
//            break;
//    }
}

@end

@implementation AnimationCollectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
