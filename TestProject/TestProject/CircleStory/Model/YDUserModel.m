//
//  YDUserModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDUserModel.h"

@implementation YDUserModel

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"avatar" : @"avatar",
             @"gender" : @"gender",
             @"lv" : @"lv",
             @"name" : @"name",
             @"followStatus" : @"follow_status",
             @"userId" : @"user_id",
             @"honorTitle" : @"honor_title",
             @"talentTitle" : @"talent_title",
             @"honorTitleIconUrl" : @"honor_title_icon_url",
             @"isMemberShip":@"is_membership",
             };
}
@end
