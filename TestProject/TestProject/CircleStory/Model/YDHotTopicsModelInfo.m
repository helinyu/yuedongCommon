//
//  YDHotTopicsModelInfo.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDHotTopicsModelInfo.h"
#import "YDHotTopicModel.h"
#import "YDTopicRecommendInfo.h"

@implementation YDHotTopicsModelInfo

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"allHotArticlesUrl" : @"all_hot_articles_jump_action",
             @"articles" : @"articles",
             @"hasMore" : @"has_more",
             @"recomAction" : @"recom_action",
             @"position" : @"position",
             @"recommendInfos" : @"recommend_infos",
             };
}
+ (NSDictionary *)keyClass {
    return @{
             @"articles" :[YDHotTopicModel class],
             @"recommendInfos" :[YDTopicRecommendInfo class],
             };
}
@end
