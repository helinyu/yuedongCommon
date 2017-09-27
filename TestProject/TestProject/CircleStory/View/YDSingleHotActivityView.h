//
//  YDSingleHotActivityView.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDActivityModel;

@class YDGradientBarView;
@interface YDSingleHotActivityView : UIView

@property (nonatomic,   weak) UILabel *titleLabel;
@property (nonatomic,   weak) UILabel *subTitleLabel;
@property (nonatomic,   weak) UIImageView *backImageView;
//@property (nonatomic,   weak) YDGradientBarView *shadowView;

@property (nonatomic, strong) YDActivityModel *model;
@property (nonatomic,   copy) void(^action)();

@end
