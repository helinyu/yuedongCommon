//
//  YDCircleThemeModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleThemeModel.h"

@implementation YDCircleThemeModel

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"themeId" : @"theme_id",
             @"themeTitle" : @"theme_title",
             @"themeIconUrl" : @"thmem_icon_url"
             };
}

@end
