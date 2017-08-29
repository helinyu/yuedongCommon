//
//  QYPedometerManager.h
//  QYPedometerDemo
//
//  Created by 田 on 16/5/19.
//  Copyright © 2016年 田鹏涛. All rights reserved.
//
/**
 *  计步器管理类
 */

#import "QYPedometerData.h"
#import <UIKit/UIKit.h>

typedef void (^QYPedometerHandler)(QYPedometerData *pedometerData, NSError *error);

@interface QYPedometerManager : NSObject

- (void)startPedometerUpdatesTodayWithHandler:(QYPedometerHandler)handler;

@end
