//
//  TimeConversion.m
//  SportsBar
//
//  Created by zmj on 14-4-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TimeConversion.h"

#import <DateTools.h>

@implementation TimeConversion

+(NSString *)conversionEnWithSecond:(NSNumber *)second
{
    NSDictionary *mDic=@{@"1": @"January",@"2": @"February",@"3": @"March",@"4": @"April",@"5": @"May",@"6": @"June",@"7": @"July",@"8": @"August",@"9": @"September",@"10": @"October",@"11": @"November",@"12": @"December"};
    
    NSDateFormatter *dateFormatterM = [[NSDateFormatter alloc] init];
    [dateFormatterM setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatterM setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatterM setDateFormat:@"M"];
    NSString *strM=[dateFormatterM stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    strM=[mDic objectForKey:strM];
    
    NSDateFormatter *dateFormatterD = [[NSDateFormatter alloc] init];
    [dateFormatterD setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatterD setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatterD setDateFormat:@"dd"];
    NSString *strD=[dateFormatterD stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    
    NSString *str=[NSString stringWithFormat:@"%@%@",strM,strD];
    return str;
}

+(NSString *)conversionWithSecond:(NSNumber *)second{
    NSDate          *currentTime        =[[NSDate alloc]init];//获取当前时间
    NSDateFormatter *currentFormatter   =[[NSDateFormatter alloc]init];
    [currentFormatter setDateStyle:NSDateFormatterMediumStyle];
    [currentFormatter setTimeStyle:NSDateFormatterShortStyle];
    [currentFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTimestr=[currentFormatter stringFromDate:currentTime];
    
    //得到时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    //比较当前时间
    if ([str isEqualToString:currentTimestr]) {
        [dateFormatter setDateFormat:@"HH:mm"];
        str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    }
    else
    {
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    }
    return str;
}

+(NSString *)getDayTimeWithSecond:(NSNumber *)second{
    
    //得到时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    
    NSArray *arr=[str componentsSeparatedByString:@":"];
    NSInteger hourNum=((NSString *)arr[0]).integerValue;
    NSString *hourStr=[NSString string];
    if (hourNum<=6) {
        hourStr=[NSString stringWithFormat:@"%@ %ld", @"凌晨", (long)hourNum];
    }
    else if (hourNum<=11)
    {
        hourStr=[NSString stringWithFormat:@"%@ %ld", @"上午", (long)hourNum];
    }
    else if (hourNum==12)
    {
        hourStr=[NSString stringWithFormat:@"%@ %ld", @"中午", (long)hourNum];
    }
    else if (hourNum<=18)
    {
        hourStr=[NSString stringWithFormat:@"%@ %ld", @"下午", (long)(hourNum-12)];
    }
    else if (hourNum==19)
    {
        hourStr=[NSString stringWithFormat:@"%@ %ld", @"傍晚", (long)(hourNum-12)];
    }
    else if (hourNum<=22)
    {
        hourStr=[NSString stringWithFormat:@"%@ %ld",@"晚上", (long)(hourNum-12)];
    }
    else if (hourNum==23)
    {
        hourStr=[NSString stringWithFormat:@"%@ %ld", @"深夜", (long)(hourNum-12)];
    }
    NSString *dayTime=[NSString stringWithFormat:@"%@:%@",hourStr,arr[1]];

    return dayTime;
}

+(NSInteger)getHourNumWithSecond:(NSNumber *)second
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    NSArray *arr=[str componentsSeparatedByString:@":"];
    NSInteger hourNum=((NSString *)arr[0]).integerValue;
    return hourNum;
}

+(NSString *)getFullDateWithSecond:(NSNumber *)second
{
    //得到时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    return str;
}

+(NSString *)getMonthWithSecond:(NSNumber *)second
{
    //得到时间
    
    NSString *str= [[NSDate dateWithTimeIntervalSince1970:[second doubleValue]] formattedDateWithFormat: @"M月" locale: [NSLocale localeWithLocaleIdentifier:@"common.locale"]];
    return str;
}

+(NSString *)getMonthDayWithSecond:(NSNumber *)second
{
    //得到时间
    
    NSString *str= [[NSDate dateWithTimeIntervalSince1970:[second doubleValue]] formattedDateWithFormat: @"MM月dd日" locale: [NSLocale localeWithLocaleIdentifier:@"common.locale"]];
    return str;
}

+(NSString *)getDayIdWithSecond:(NSNumber *)second{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    return str;
}


+(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

-(void)dhmWithDeadlineTime:(NSNumber *)deadlineTime andBeginTime:(NSNumber *)beginTime andEndTime:(NSNumber *)endTime
{
    deadlineTime=[NSNumber numberWithInt:beginTime.doubleValue-deadlineTime.doubleValue];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSInteger length=deadlineTime.doubleValue-time;
    
    if (length>=HOURS_OF_DAY*MINUTES_OF_HOUR*SECONDS_OF_MINUTE) {
        self.timeUnit= @"天";
        NSInteger dayNum=length/86400;
        if (dayNum<100) {
            self.timeNum=[NSString stringWithFormat:@"%@",@(length/86400)];
        }
        else
        {
            self.timeNum=@"99+";
        }
        self.type=ActivityUnDeadline;
    }
    else if (length>=MINUTES_OF_HOUR*SECONDS_OF_MINUTE)
    {
        self.timeUnit= @"小时";
        self.timeNum=[NSString stringWithFormat:@"%@",@(length/3600)];
        self.type=ActivityUnDeadline;
    }
    else if (length>=0)
    {
        self.timeUnit= @"分钟";
        self.timeNum=[NSString stringWithFormat:@"%@",@(length/60)];
        self.type=ActivityUnDeadline;

    }
    else if (time<beginTime.doubleValue)
    {
        self.type=ActivityDeadline;
        self.activityStatus= @"报名截止";
    }
    else if((time>=beginTime.doubleValue) && (time<=endTime.doubleValue))
    {
        self.type=ActivityStart;
        self.activityStatus= @"进行中";
    }
    else
    {
        self.type=ActivityEnd;
        self.activityStatus= @"已结束";
    }
}
+(NSString *)timeLengthWithBeginTime:(NSNumber *)beginTime andEndTime:(NSNumber *)endTime
{
    NSInteger length=endTime.doubleValue-beginTime.doubleValue;
    length+=1;//矫正误差
    NSString *str;
    if (length>=HOURS_OF_DAY*MINUTES_OF_HOUR*SECONDS_OF_MINUTE) {
        NSInteger dayNum=length/86400;
        if (dayNum<100) {
            str=[NSString stringWithFormat:@"%@%@",@(length/86400), @"天"];
        }
        else
        {
            str= [NSString stringWithFormat: @"99+%@", @"天"];
        }
    }
    else if (length>=MINUTES_OF_HOUR*SECONDS_OF_MINUTE)
    {
        str=[NSString stringWithFormat:@"%@%@",@(length/3600), @"小时"];
    }
    else if (length>=0)
    {
        str=[NSString stringWithFormat:@"%@%@",@(length/60), @"分钟"];
    }
    return str;
}

+(NSString *)timeLengthWithTimelength:(NSInteger)length
{
    length+=1;//矫正误差
    NSString *str;
    if (length>=HOURS_OF_DAY*MINUTES_OF_HOUR*SECONDS_OF_MINUTE) {
        NSInteger dayNum=length/86400;
        if (dayNum<100) {
            str=[NSString stringWithFormat:@"%@%@",@(length/86400), @"天"];
        }
        else
        {
            str=[NSString stringWithFormat: @"99+%@",@"天"];
        }
    }
    else if (length>=MINUTES_OF_HOUR*SECONDS_OF_MINUTE)
    {
        str=[NSString stringWithFormat:@"%@%@",@(length/3600),  @"小时"];
    }
    else if (length>=0)
    {
        str=[NSString stringWithFormat:@"%@%@",@(length/60), @"分钟"];
    }
    return str;
}

+(NSNumber *)getDayNumWithSecond:(NSNumber *)second
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    NSNumber *dayNum=[NSNumber numberWithInteger:str.integerValue];
    return dayNum;
}
+(NSNumber *)getDaySeqWithSecond:(NSNumber *)second
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *str=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second doubleValue]]];
    NSArray *arr=[str componentsSeparatedByString:@":"];
    NSInteger hourNum=((NSString *)arr[0]).integerValue;
    NSInteger minuteNum = ((NSString *)arr[1]).integerValue;
    NSNumber *daySeq = [NSNumber numberWithInteger:(hourNum*12 + minuteNum/5 +1)];
    return daySeq;
}
+(NSNumber *)numberFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *str=[dateFormatter stringFromDate:date];
    NSNumber *dayNum=[NSNumber numberWithInteger:str.integerValue];
    return dayNum;
}
@end
