//
//  YDChartlineView.m
//  TestCoreText
//
//  Created by mac on 13/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDChartlineViewTCell.h"

@interface YDChartlineViewTCell ()

@property (nonatomic, strong) CALayer *verticalLineLayer;
@property (nonatomic, strong) CALayer *horizontalLineLayer;
@property (nonatomic, strong) CAShapeLayer *trendLayer;

@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) CATextLayer *dotTextLayer;

@property (nonatomic, strong) CATextLayer *timeTextLayer;

@end

@implementation YDChartlineViewTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    self.layer.masksToBounds =NO;
    [self setClipsToBounds:NO];
    self.backgroundColor = [UIColor grayColor];
    self.layer.borderWidth = 0.f;
    [self.contentView removeFromSuperview];
    
    if (!_verticalLineLayer) {
        _verticalLineLayer = [CALayer new];
        [self.layer addSublayer:_verticalLineLayer];
    }
    
    if (!_horizontalLineLayer) {
        _horizontalLineLayer = [CALayer new];
        [self.layer addSublayer:_horizontalLineLayer];
    }
    
    if (!_trendLayer) {
        _trendLayer = [CAShapeLayer new];
       [self.layer addSublayer:_trendLayer];
    }
    
    if (!_dotLayer) {
        _dotLayer = [CALayer new];
        [self.layer addSublayer:_dotLayer];
    }
    
    if (!_dotTextLayer) {
        _dotTextLayer = [CATextLayer new];
        [self.layer addSublayer:_dotTextLayer];
    }
    
    if (!_timeTextLayer) {
        _timeTextLayer = [CATextLayer new];
        [self.layer addSublayer:_timeTextLayer];
    }
    
    _verticalLineLayer.frame = CGRectMake(50.f, 0, 5.f, self.bounds.size.height);
    _verticalLineLayer.backgroundColor = [UIColor yellowColor].CGColor;

    _horizontalLineLayer.frame = CGRectMake(50.f, (self.size.height -5.f)/2.f, [UIScreen mainScreen].bounds.size.width -50, 5.f);
    _horizontalLineLayer.backgroundColor = [UIColor redColor].CGColor;
    _timeTextLayer.frame = CGRectMake(0, 10.f, 50.f, self.size.height);
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    _timeTextLayer.font = fontRef;
    _timeTextLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);

    _dotLayer.frame = CGRectMake(0, (self.size.height -8.f)/2.f, 8.f, 8.f);
    _dotLayer.hidden = YES;
    _dotLayer.backgroundColor = [UIColor blueColor].CGColor;
    _trendLayer.strokeColor = [UIColor greenColor].CGColor;
}

- (void)setDotPoint:(CGFloat)dotPoint {
    _dotPoint = dotPoint;
    _dotLayer.hidden = NO;
    _dotLayer.frame = CGRectMake(dotPoint *([UIScreen mainScreen].bounds.size.width-50.f) +50.f, (self.size.height -8.f)/2.f, 8.f, 8.f);
}

- (void)configureStartPoint:(CGFloat)startPoint endPoint:(CGFloat)endPoint {
    _startPoint = startPoint;
    _endPoint = endPoint;
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(_startPoint *([UIScreen mainScreen].bounds.size.width-50.f)+50.f, 0.f)];
    [path addLineToPoint:CGPointMake(_endPoint *([UIScreen mainScreen].bounds.size.width-50.f) + 50.f, self.size.height)];
    _trendLayer.strokeColor = [UIColor greenColor].CGColor;
    _trendLayer.lineWidth = 2.f;
    _trendLayer.fillColor = [UIColor clearColor].CGColor;
    _trendLayer.path = path.CGPath;
}

- (void)configureDotPoint:(CGFloat)dotPoint oneOfDoubleEndPoint:(CGFloat)oneEndPoint isStart:(BOOL)flag {
    if (flag) {
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(dotPoint *([UIScreen mainScreen].bounds.size.width-50.f)+50.f, (self.height -2.f)/2.f)];
        [path addLineToPoint:CGPointMake(oneEndPoint *([UIScreen mainScreen].bounds.size.width -50.f) + 50.f, self.height)];
        _trendLayer.strokeColor = [UIColor purpleColor].CGColor;
        _trendLayer.lineWidth = 2.f;
        _trendLayer.fillColor = [UIColor clearColor].CGColor;
        _trendLayer.path = path.CGPath;
    }
    else {
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(oneEndPoint *([UIScreen mainScreen].bounds.size.width-50.f) + 50.f, 0.f)];
        [path addLineToPoint:CGPointMake(dotPoint *([UIScreen mainScreen].bounds.size.width-50.f)+50.f, (self.height -2.f)/2.f)];
        _trendLayer.strokeColor = [UIColor orangeColor].CGColor;
        _trendLayer.lineWidth = 2.f;
        _trendLayer.fillColor = [UIColor clearColor].CGColor;
        _trendLayer.path = path.CGPath;
    }
    _trendLayer.lineJoin = kCALineJoinBevel;
    _trendLayer.lineCap = kCALineCapSquare;
}

- (void)configureDotPoint:(CGFloat)dotPoint startPoint:(CGFloat)startPoint endPoint:(CGFloat)endPoint dotPoint:(CGFloat)dotPoint {
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(startPoint *([UIScreen mainScreen].bounds.size.width-50.f) + 50.f, 0.f)];
    [path addLineToPoint:CGPointMake(dotPoint *([UIScreen mainScreen].bounds.size.width-50.f)+50.f, (self.height -2.f)/2.f)];
    [path addLineToPoint:CGPointMake(([UIScreen mainScreen].bounds.size.width-50.f)*endPoint + 50.f, self.height)];
    _trendLayer.strokeColor = [UIColor orangeColor].CGColor;
    _trendLayer.lineWidth = 2.f;
    _trendLayer.fillColor = [UIColor clearColor].CGColor;
    _trendLayer.path = path.CGPath;
    
}

- (void)setTimeText:(NSString *)timeText {
    _timeText = timeText;
    _timeTextLayer.string = timeText;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _dotLayer.hidden = YES;
}

@end
