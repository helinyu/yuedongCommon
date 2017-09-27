//
//  YDCircleChoicenessCell.h
//  SportsBar
//
//  Created by 颜志浩 on 16/12/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDSingleCircleView;
@class YDCircleThemeModel;
@interface YDCircleChoicenessCell : UITableViewCell
@property (nonatomic,   weak) YDSingleCircleView *live;
@property (nonatomic,   weak) YDSingleCircleView *sportCyclopedia;
@property (nonatomic,   weak) YDSingleCircleView *topicDiscuss;
@property (nonatomic,   weak) YDSingleCircleView *fitnessVideo;
@property (nonatomic, strong) NSArray<YDCircleThemeModel *> *themeInfos;
@property (nonatomic,   copy) void(^action)();
@end
