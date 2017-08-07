//
//  TimeConversion.h
//  SportsBar
//
//  Created by zmj on 14-4-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    ActivityUnDeadline = 0, // 未截止--显示截止时间
    ActivityDeadline = 1, //截止报名
    ActivityStart = 2, //进行中
    ActivityEnd = 3 //已结束
} ActivityStatusType;

#define HOURS_OF_DAY 24
#define SECONDS_OF_MINUTE 60
#define MINUTES_OF_HOUR 60

@interface TimeConversion : NSObject
@property (nonatomic, assign) ActivityStatusType type;
@property (nonatomic, copy) NSString * timeNum;
@property (nonatomic, copy) NSString * timeUnit;
@property (nonatomic, copy) NSString * activityStatus;


+(NSString *)timeLengthWithTimelength:(NSInteger)length;
+(NSString *)conversionWithSecond:(NSNumber *)second;
+(NSString *)conversionEnWithSecond:(NSNumber *)second;
+(NSString *)getFullDateWithSecond:(NSNumber *)second;
+(NSString *)getMonthWithSecond:(NSNumber *)second;
+(NSString *)getMonthDayWithSecond:(NSNumber *)second;
+(NSNumber *)getDayNumWithSecond:(NSNumber *)second;
+(NSInteger)getHourNumWithSecond:(NSNumber *)second;
+(NSString *)getDayTimeWithSecond:(NSNumber *)second;
+(NSNumber *)getDaySeqWithSecond:(NSNumber *)second;
+(NSString *)getDayIdWithSecond:(NSNumber *)second;

+(NSString *)stringFromDate:(NSDate *)date;

+(NSNumber *)numberFromDate:(NSDate *)date;


-(void)dhmWithDeadlineTime:(NSNumber *)deadlineTime andBeginTime:(NSNumber *)beginTime andEndTime:(NSNumber *)endTime;

+(NSString *)timeLengthWithBeginTime:(NSNumber *)beginTime andEndTime:(NSNumber *)endTime;

@end
