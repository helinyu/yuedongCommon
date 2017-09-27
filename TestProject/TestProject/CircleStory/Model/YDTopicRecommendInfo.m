//
//  YDTopicRecommendInfo.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDTopicRecommendInfo.h"

@interface YDTopicRecommendInfo ()<MSJsonSerializing>


@end

@implementation YDTopicRecommendInfo

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"userId" : @"user_id",
             @"nick" : @"nick",
             @"talentTitle" : @"talent_title",
             @"followStatus" : @"follow_status",
             };
}

@end
