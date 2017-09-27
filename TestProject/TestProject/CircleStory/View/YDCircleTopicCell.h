//
//  YDCircleTopicCell.h
//  YDOriginalCircle
//
//  Created by 颜志浩 on 16/8/12.
//  Copyright © 2016年 颜志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDHotTopicModel;
@interface YDCircleTopicCell : UITableViewCell

@property (nonatomic, strong) YDHotTopicModel *model;
@property (nonatomic,   copy) void(^userFollowAction)(NSNumber *userId, NSNumber *followUserId);
@property (nonatomic,   copy) void(^userLikeAction)();
@property (nonatomic,   weak) UIButton *followBtn;
@property (nonatomic,   weak) UIButton *likeButton;
@property (nonatomic,   weak) UILabel *likeCountLabel;
@property (nonatomic,   weak) UILabel *likeAnimationLabel;

@end
