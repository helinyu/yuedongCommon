//
//  QYPedometerManager.m
//  QYPedometerDemo
//
//  Created by 田 on 16/5/19.
//  Copyright © 2016年 田鹏涛. All rights reserved.
//

#import "QYPedometerManager.h"
#import <CoreMotion/CoreMotion.h>

@interface QYPedometerManager ()
//这个一定是该类中的全局变量，因为这个过程中是异步的，所以在返回来的时候一定是存在的
@property(nonatomic, strong) CMPedometer *pedometer;
@end
@implementation QYPedometerManager

- (instancetype)init {
  self = [super init];
  if (self) {
    if ([CMPedometer isStepCountingAvailable]) {
        if(!_pedometer)
          _pedometer = [[CMPedometer alloc] init];
        }
  }
  return self;
}

- (void)startPedometerUpdatesTodayWithHandler:(QYPedometerHandler)handler;
{
    NSDate *toDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
    if ([CMPedometer isStepCountingAvailable]) {
        [self.pedometer startPedometerUpdatesFromDate:fromDate withHandler:^(CMPedometerData *_Nullable pedometerData, NSError *_Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                QYPedometerData *customPedometerData = [[QYPedometerData alloc] init];
                customPedometerData.numberOfSteps = pedometerData.numberOfSteps;
                customPedometerData.distance = pedometerData.distance;
                customPedometerData.floorsAscended = pedometerData.floorsAscended;
                customPedometerData.floorsDescended = pedometerData.floorsDescended;
                handler(customPedometerData, error);
            });
        }];
    }
}

@end
