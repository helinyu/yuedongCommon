//
//  YDCircleBannerModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleBannerModel.h"

@implementation YDCircleBannerModel

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"action" : @"action",
             @"adIdentify" : @"ad_identify",
             @"image" : @"image",
             @"userId" : @"user_id",
             @"statName" : @"stat_name",
             @"redirectUrl" : @"redirect_url"
             };
}


@end
