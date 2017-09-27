//
//  YDCircleSubThemeModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleSubThemeModel.h"

@implementation YDCircleSubThemeModel

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"subThemeIconId" : @"sub_theme_icon_id",
             @"subThemeId" : @"sub_theme_id",
             @"subThemeIconUrl" : @"sub_theme_icon_url",
             @"subThemeNum" : @"sub_theme_num",
             @"subThemeNumStr" : @"sub_theme_num_str",
             @"subThemeTitle" : @"sub_theme_title",
             @"subThemeType" : @"sub_theme_type",
             @"subThemeUnit" : @"sub_theme_unit",
             @"recommendTitle" : @"recommend_title",
             };
}

@end
