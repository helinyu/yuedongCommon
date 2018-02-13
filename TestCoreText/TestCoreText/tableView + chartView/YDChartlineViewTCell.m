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

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    if (!_verticalLineLayer) {
        _verticalLineLayer = [CALayer new];
        [self.contentView.layer addSublayer:_verticalLineLayer];
    }
    
    if (!_horizontalLineLayer) {
        _horizontalLineLayer = [CALayer new];
        [self.contentView.layer addSublayer:_horizontalLineLayer];
    }
    
    if (!_trendLayer) {
        _trendLayer = [CAShapeLayer new];
       [self.contentView.layer addSublayer:_trendLayer];
    }
    
    if (!_dotLayer) {
        _dotLayer = [CALayer new];
        [self.contentView.layer addSublayer:_dotLayer];
    }
    
    if (!_dotTextLayer) {
        _dotTextLayer = [CATextLayer new];
        [self.contentView.layer addSublayer:_dotTextLayer];
    }
    
    if (!_timeTextLayer) {
        _timeTextLayer = [CATextLayer new];
        [self.contentView.layer addSublayer:_timeTextLayer];
    }
    
    _verticalLineLayer.frame = CGRectMake(50.f, 0, 5.f, self.bounds.size.height);
    _verticalLineLayer.backgroundColor = [UIColor yellowColor].CGColor;
    _horizontalLineLayer.frame = CGRectMake(50.f, (self.size.height-5.f)/2.f, self.size.width-50.f, 5.f);
    _horizontalLineLayer.backgroundColor = [UIColor redColor].CGColor;
    _timeTextLayer.frame = CGRectMake(0, 0, 50.f, self.size.height);
    _timeTextLayer.foregroundColor = [UIColor redColor].CGColor;
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
    _trendLayer.fillColor = [UIColor redColor].CGColor;
}

- (void)setDotPoint:(CGFloat)dotPoint {
    _dotPoint = dotPoint;
    _dotLayer.hidden = NO;
    _dotLayer.frame = CGRectMake(dotPoint *self.size.width-50.f-4.f, (self.size.height -8.f)/2.f, 8.f, 8.f);
}

- (void)configureStartPoint:(CGFloat)startPoint endPoint:(CGFloat)endPoint {
    _startPoint = startPoint;
    _endPoint = endPoint;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(_startPoint, 0.f)];
    [path moveToPoint:CGPointMake(_endPoint, self.size.height)];
    [path closePath];  _trendLayer.strokeColor = [UIColor greenColor].CGColor;
    _trendLayer.fillColor = [UIColor redColor].CGColor;
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
