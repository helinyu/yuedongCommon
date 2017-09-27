//
//  YDUserCirclesModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDUserCirclesModel.h"
#import "YDOriginCircleModel.h"

@implementation YDUserCirclesModel

//@property (nonatomic, strong) NSArray<YDOriginCircleModel *> *circles;
//@property (nonatomic, strong) NSNumber *userId;

+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"addCircleJumpAction" : @"add_circle_jump_action",
             @"allCircleJumpAction" : @"all_circle_jump_action",
             @"circleRunGuide" : @"circle_run_guide",
             @"circleRunGuideUrl" : @"circle_run_guide_url",
             @"circles" : @"circles",
             @"userId" : @"user_id"
             };
}

+ (NSDictionary *)keyClass {
    return @{
             @"circles" :[YDOriginCircleModel class]
             };
}
@end
