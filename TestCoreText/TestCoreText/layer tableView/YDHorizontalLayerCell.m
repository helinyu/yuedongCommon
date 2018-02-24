//
//  YDLayerCell.m
//  TestCoreText
//
//  Created by mac on 22/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHorizontalLayerCell.h"

@interface YDHorizontalLayerCell ()

@property (nonatomic, strong) CAShapeLayer *verticalLayer;
@property (nonatomic, strong) CAShapeLayer *horizontalLayer;
@property (nonatomic, strong) CAShapeLayer *dotLayer;
@property (nonatomic, strong) CATextLayer *textDateLayer;

@property (nonatomic, strong) CAShapeLayer *trendLayer;

@end

@implementation YDHorizontalLayerCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    _verticalLayer = [CAShapeLayer new];
    [self addSublayer:_verticalLayer];

    _horizontalLayer = [CAShapeLayer new];
    [self addSublayer:_horizontalLayer];

    _dotLayer = [CAShapeLayer new];
    [self addSublayer:_dotLayer];

    _textDateLayer = [CATextLayer new];
    [self addSublayer:_textDateLayer];
    
    _trendLayer = [CAShapeLayer new];
    [self addSublayer:_trendLayer];
}

- (void)configureWithDate:(NSString *)dateString dotPoint:(CGFloat)dotPoint {
    _verticalLayer.frame = CGRectMake(self.bounds.size.width/2, 0.f, 2.f, self.bounds.size.height);
    _verticalLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    _horizontalLayer.frame = CGRectMake(0.f, self.bounds.size.height -50, self.bounds.size.width, 2.f);
    _horizontalLayer.backgroundColor =[UIColor purpleColor].CGColor;
    
    _textDateLayer.string = dateString;
    _textDateLayer.backgroundColor = [UIColor orangeColor].CGColor;
    _textDateLayer.frame = CGRectMake(self.bounds.size.width/2 -15.f, self.bounds.size.height -45.f, 30.f, 30.f);
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    _textDateLayer.font = fontRef;
    _textDateLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    _dotLayer.frame = CGRectMake(self.bounds.size.width/2, (self.bounds.size.height -50.f) *dotPoint, 8.f, 8.f);
    _dotLayer.backgroundColor = [UIColor magentaColor].CGColor;
}

- (void)configureStartPoint:(CGFloat)startPoint endPoint:(CGFloat)endPoint {
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, startPoint *(self.bounds.size.height-50.f))];
    [path addLineToPoint:CGPointMake(self.bounds.size.width,endPoint *(self.bounds.size.height-50.f))];
    _trendLayer.strokeColor = [UIColor greenColor].CGColor;
    _trendLayer.lineWidth = 2.f;
    _trendLayer.fillColor = [UIColor clearColor].CGColor;
    _trendLayer.path = path.CGPath;
}

- (void)configureDotPoint:(CGFloat)dotPoint oneOfDoubleEndPoint:(CGFloat)oneEndPoint isStart:(BOOL)flag {
    _dotLayer.hidden = NO;
    if (flag) {
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake((self.bounds.size.width)/2.f, (self.bounds.size.height -50.f)*dotPoint)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, (self.bounds.size.height -50.f)*oneEndPoint)];
        _trendLayer.strokeColor = [UIColor purpleColor].CGColor;
        _trendLayer.lineWidth = 2.f;
        _trendLayer.fillColor = [UIColor clearColor].CGColor;
        _trendLayer.path = path.CGPath;
    }
    else {
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(0.f, oneEndPoint *(self.bounds.size.height -50.f))];
        [path addLineToPoint:CGPointMake(self.bounds.size.width/2.f, (self.bounds.size.height -50.f) *oneEndPoint)];
        _trendLayer.strokeColor = [UIColor orangeColor].CGColor;
        _trendLayer.lineWidth = 2.f;
        _trendLayer.fillColor = [UIColor clearColor].CGColor;
        _trendLayer.path = path.CGPath;
    }
    _trendLayer.lineJoin = kCALineJoinBevel;
    _trendLayer.lineCap = kCALineCapSquare;
}

- (void)configureDotPoint:(CGFloat)dotPoint startPoint:(CGFloat)startPoint endPoint:(CGFloat)endPoint {
    _dotLayer.hidden = NO;
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0.f, startPoint *(self.bounds.size.height -50.f))];
    [path addLineToPoint:CGPointMake(self.bounds.size.width/2.f, (self.bounds.size.height -50.f)*dotPoint)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, (self.bounds.size.height -50) *endPoint)];
    _trendLayer.strokeColor = [UIColor orangeColor].CGColor;
    _trendLayer.lineWidth = 2.f;
    _trendLayer.fillColor = [UIColor clearColor].CGColor;
    _trendLayer.path = path.CGPath;
}

- (void)prepareForReuse {
    self.dotLayer.hidden = YES;
}

@end
