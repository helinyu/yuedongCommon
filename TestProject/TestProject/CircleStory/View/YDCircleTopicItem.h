//
//  YDCircleTopicItem.h
//  SportsBar
//
//  Created by 颜志浩 on 17/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDHotTopicModel;

@interface YDCircleTopicItem : UICollectionViewCell

@property (nonatomic, strong) YDHotTopicModel *model;
@property (nonatomic,   copy) void(^userFollowAction)(NSNumber *userId, NSNumber *followUserId);
@property (nonatomic,   copy) void(^userLikeAction)();
@property (nonatomic,   copy) void(^userDiscussAction)();
@property (nonatomic,   weak) UIButton *followBtn;
@property (nonatomic,   weak) UIButton *likeButton;
@property (nonatomic,   weak) UILabel *likeCountLabel;
@property (nonatomic,   weak) UILabel *likeAnimationLabel;

@end
