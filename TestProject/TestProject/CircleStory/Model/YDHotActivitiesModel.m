//
//  YDHotActivitiesModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDHotActivitiesModel.h"
#import "YDActivityModel.h"

@implementation YDHotActivitiesModel

//@property (nonatomic, strong) NSArray<YDActivityModel *> *activities;
//@property (nonatomic,   copy) NSString *allActivityJumpAction;

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"activities" : @"activities",
             @"allActivityJumpAction" : @"all_activity_jump_action"
             };
}

+ (NSDictionary *)keyClass {
    return @{
             @"activities" :[YDActivityModel class]
             };
}
@end
