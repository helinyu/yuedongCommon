//
//  YDChartLayerCell.h
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHorizontalBaseLayerCell.h"

//static const CGFloat kBottomHPercent = 0.1;
static const CGFloat kBottomH = 50.f;
// 内容长度  = 总内容 = kBottomH

@interface YDChartLayerCell : YDHorizontalBaseLayerCell

@property (nonatomic, strong) CATextLayer *dateTextLayer;
@property (nonatomic, strong) CAShapeLayer *horizontalLineLayer;
@property (nonatomic, strong) CAShapeLayer *verticalLineLayer;
@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) CAShapeLayer *chartLayer;

@end
