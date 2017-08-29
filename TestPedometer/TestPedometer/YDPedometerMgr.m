//
//  YDPedometerMgr.m
//  TestPedometer
//
//  Created by Aka on 2017/8/29.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDPedometerMgr.h"
#import <CoreMotion/CoreMotion.h>

@interface YDPedometerMgr ()

@property (nonatomic, strong) CMPedometer *pedometer;

@end

@implementation YDPedometerMgr

+ (BOOL)isAvaibleCheckAll {
    return ([CMPedometer isStepCountingAvailable] && [CMPedometer isDistanceAvailable] && [CMPedometer isFloorCountingAvailable] && [CMPedometer isPaceAvailable] && [CMPedometer isPaceAvailable] && [CMPedometer isCadenceAvailable]);
}

@end
