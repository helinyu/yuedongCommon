//
//  YDUserCirclesModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@class YDOriginCircleModel;
@interface YDUserCirclesModel : NSObject<MSJsonSerializing>
/**
 *  添加圈子
 */
@property (nonatomic,   copy) NSString *addCircleJumpAction;
/**
 *  所有圈子
 */
@property (nonatomic,   copy) NSString *allCircleJumpAction;
@property (nonatomic,   copy) NSString *circleRunGuide;
/**
 *  圈子挑战赛新手引导跳转连接
 */
@property (nonatomic,   copy) NSString *circleRunGuideUrl;
// 原始的圈子模型
@property (nonatomic, strong) NSArray<YDOriginCircleModel *> *circles;
@property (nonatomic, strong) NSNumber *userId;

/**
 *  动画标示
 */
@property (nonatomic, assign) BOOL hasDisplayed;


@end
