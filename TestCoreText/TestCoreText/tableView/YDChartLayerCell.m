//
//  YDChartLayerCell.m
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDChartLayerCell.h"

@interface YDChartLayerCell ()


@end

@implementation YDChartLayerCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {

//    @property (nonatomic, strong) CAShapeLayer *verticalLineLayer;
//    @property (nonatomic, strong) CALayer *dotLayer;
//    @property (nonatomic, strong) CAShapeLayer *chartLayer;
    _dateTextLayer = [CATextLayer new];
    [self addSublayer:_dateTextLayer];
    
    _horizontalLineLayer = [CAShapeLayer new];
    [self addSublayer:_horizontalLineLayer];
    
    _verticalLineLayer = [CAShapeLayer new];
    [self addSublayer:_verticalLineLayer];
    
    _dotLayer = [CALayer new];
    [self addSublayer:_dotLayer];
    
    _chartLayer = [CAShapeLayer new];
}

@end
