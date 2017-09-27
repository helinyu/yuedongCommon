//
//  YDCircleThemeArticleModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleThemeArticleModel.h"

@implementation YDCircleThemeArticleModel
+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"action" : @"action",
             @"articleDiscussCnt" : @"article_discuss_cnt",
             @"articleIconUrl" : @"article_icon_url",
             @"articleId" : @"article_id",
             @"likeCnt" : @"article_like_cnt",
             @"likeFlag" : @"article_like_flag",
             @"articleTitle" : @"article_title",
             @"circle" : @"circle",
             };
}
+ (NSDictionary *)keyClass {
    return @{
             
             };
}

@end
