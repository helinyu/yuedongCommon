//
//  YDCircleThemeArticleInfos.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleThemeArticleInfos.h"
#import "YDCircleThemeArticleModel.h"

@implementation YDCircleThemeArticleInfos
+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"allHotArticlesJumpAction" : @"all_hot_articles_jump_action",
             @"hasMore" : @"has_more",
             @"infos" : @"infos",
             };
}
+ (NSDictionary *)keyClass {
    return @{
             @"infos" : [YDCircleThemeArticleModel class]
             };
}

@end
