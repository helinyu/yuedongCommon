//
//  YDHotActivitiesCell.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDSingleHotActivityView;
@class YDActivityModel;
@interface YDHotActivitiesCell : UITableViewCell

@property (nonatomic,   weak) YDSingleHotActivityView *firstActivity;
@property (nonatomic,   weak) YDSingleHotActivityView *secondActivity;
@property (nonatomic,   weak) YDSingleHotActivityView *thirdActivity;
@property (nonatomic,   weak) YDSingleHotActivityView *fourthActivity;

@property (nonatomic, strong) NSArray<YDActivityModel *> *activities;

@end
