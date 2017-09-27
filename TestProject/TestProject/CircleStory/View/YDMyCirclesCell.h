//
//  YDMyCirclesCell.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDSingleCircleView;
@class YDOriginCircleModel;
@interface YDMyCirclesCell : UITableViewCell

@property (nonatomic,   weak) YDSingleCircleView *firstCircle;
@property (nonatomic,   weak) YDSingleCircleView *secondCircle;
@property (nonatomic,   weak) YDSingleCircleView *thirdCircle;
@property (nonatomic,   weak) YDSingleCircleView *fourthCircle;

@property (nonatomic,   weak) UIView *lineView;
@property (nonatomic,   weak) UIButton *addButton;

@property (nonatomic, strong) NSArray<YDOriginCircleModel *> *circles;
@property (nonatomic,   copy) void(^action)();

@end
