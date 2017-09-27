//
//  YDSingleCircleView.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YDCellSingleViewType) {
    YDCellSingleViewTypeCircle,
    YDCellSingleViewTypeChoiceness,
};

@class YDImageControl;
@interface YDSingleCircleView : UIView
@property (nonatomic,   weak) YDImageControl *imageControl;
@property (nonatomic,   weak) UILabel *titleLabel;
@property (nonatomic,   copy) void(^action)();

- (instancetype)initWithType:(YDCellSingleViewType)type frame:(CGRect)frame;

@end
