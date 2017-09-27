//
//  YDHotTopicModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"


@class YDOriginCircleModel;
@class YDUserModel;
@interface YDHotTopicModel : NSObject<MSJsonSerializing>
/**
 *  跳转话题详情Url
 */
@property (nonatomic,   copy) NSString *action;
@property (nonatomic, strong) YDOriginCircleModel *circle;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger hotrank;
@property (nonatomic, strong) NSArray<NSString *> *images;
@property (nonatomic,   copy) NSString *text;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic,   copy) NSString *title;
@property (nonatomic, strong) YDUserModel *user;
@property (nonatomic, assign) NSInteger topicId;
@property (nonatomic, assign, getter=getHeight) CGFloat height;
@property (nonatomic, strong) NSArray *videoUrlArr;
@property (nonatomic, assign) NSInteger videoTime;
@property (nonatomic, assign) NSInteger likeCnt;
@property (nonatomic, strong) NSNumber *likeFlag;
@property (nonatomic,   copy) NSString *area;

/**
 直播
 */
@property (nonatomic, strong) NSString *param;

/**
 *  浏览量
 */
@property (nonatomic, assign) NSInteger viewCount;

/**
 *  设置动画标示
 */
@property (nonatomic, assign) BOOL hasDisplayed;
@end
