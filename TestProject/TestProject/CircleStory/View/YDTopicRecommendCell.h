//
//  YDTopicRecommendCell.h
//  SportsBar
//
//  Created by 颜志浩 on 17/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDTopicRecommendInfo;

@interface YDTopicRecommendCell : UICollectionViewCell

@property (nonatomic, strong) NSArray<YDTopicRecommendInfo *> *recommendInfos;
@property (nonatomic,   copy) void(^actionToUserInfoVc)(NSInteger userId);
@property (nonatomic,   copy) void(^action)();
@end
