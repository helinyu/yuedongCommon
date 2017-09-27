//
//  YDCircleBannerInfo.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleBannerInfo.h"
#import "YDCircleBannerModel.h"


@implementation YDCircleBannerInfo

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"banners" : @"banners",
             @"whRatio" : @"wh_ratio"
             };
}

+ (NSDictionary *)keyClass {
    return @{
             @"banners" :[YDCircleBannerModel class]
             };
}
@end
