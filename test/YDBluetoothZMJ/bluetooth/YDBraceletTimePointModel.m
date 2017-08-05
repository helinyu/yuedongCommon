//
//  YDBraceletTimePointModel.m
//  DoStyle
//
//  Created by zmj on 14-9-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "YDBraceletTimePointModel.h"

@implementation YDBraceletTimePointModel
-(id)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        _seq = dic[@"seq"];
        _step = dic[@"step"];
        _calorie = dic[@"calorie"];
        _distance = dic[@"distance"];
        _sleep = dic[@"sleep"];
    }
    return self;
}
@end

// {runner_id, point_id, longitude, latitude, time,}