//
//  YDCircleModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDOriginCircleModel.h"

@implementation YDOriginCircleModel

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"icon" : @"icon",
             @"name" : @"name",
             @"action" : @"action",
             @"circleId" : @"circle_id",
             @"redPoint" : @"red_flag",
             @"timestamp" : @"last_update_ts"
             };
}
@end
