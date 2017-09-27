//
//  YDTopicRecommendInfo.h
//  SportsBar
//
//  Created by 颜志浩 on 17/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDTopicRecommendInfo : NSObject

// user_id,nick,talent_title,follow_status
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic,   copy) NSString *nick;
@property (nonatomic,   copy) NSString *talentTitle;
@property (nonatomic, strong) NSNumber *followStatus;

@end
