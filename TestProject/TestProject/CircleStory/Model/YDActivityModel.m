//
//  YDActivityModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDActivityModel.h"

@implementation YDActivityModel


+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"action" : @"action",
             @"circleId" : @"circle_id",
             @"desc" : @"desc",
             @"kDescription" : @"description",
             @"groupRunId" : @"group_run_id",
             @"icon" : @"icon",
             @"kindId" : @"kind_id",
             @"title" : @"title",
             @"iconNew" : @"icon_new",
             };
}
@end
