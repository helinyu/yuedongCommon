//
//  YDCircleModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

/**
 *  圈子
 */
@interface YDOriginCircleModel : NSObject<MSJsonSerializing>

@property (nonatomic,   copy) NSString *icon;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *action;

// 红点新增
@property (nonatomic, copy) NSNumber *circleId;
@property (nonatomic, assign) BOOL redPoint;
@property (nonatomic, assign) NSTimeInterval timestamp;

@end
