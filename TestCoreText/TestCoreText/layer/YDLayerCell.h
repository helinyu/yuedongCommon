//
//  YDLayerCell.h
//  TestCoreText
//
//  Created by mac on 22/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "YDHorizontalBaseLayerCell.h"

@interface YDLayerCell : YDHorizontalBaseLayerCell

- (void)configureWithDate:(NSString *)dateString dotPoint:(CGFloat)dotPoint;

- (void)configureStartPoint:(CGFloat)startPoint endPoint:(CGFloat)endPoint;
- (void)configureDotPoint:(CGFloat)dotPoint oneOfDoubleEndPoint:(CGFloat)oneEndPoint isStart:(BOOL)flag;
- (void)configureDotPoint:(CGFloat)dotPoint startPoint:(CGFloat)startPoint endPoint:(CGFloat)endPoint;

- (void)prepareForReuse;

@end
