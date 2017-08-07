//
//  MSStringKit.m
//  SportsInternational
//
//  Created by 张旻可 on 15/9/1.
//  Copyright (c) 2015年 yuedong. All rights reserved.
//

#import "MSStringKit.h"

static NSString *const ipReg = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
static NSString *const inValidIDFAReg = @"[0\\-]*";

@implementation MSStringKit

+ (NSString *)genUUID {
    return [[NSUUID UUID] UUIDString];
}
+ (BOOL)isNetPath: (NSString *)path {
    if ([path rangeOfString: @"http://"].location != NSNotFound ||
        [path rangeOfString: @"https://"].location != NSNotFound ||
        [path rangeOfString: @"ftp://"].location != NSNotFound) {
        return YES;
    }
    return NO;
}
+(BOOL)isEmptyStr: (NSString*)strCheck {
    if (strCheck == nil || strCheck.length == 0) {
        return YES;
    }
    BOOL bRet = NO;
    NSString *str=[strCheck stringByReplacingOccurrencesOfString:@" " withString:@""];//去空格
    if (str == nil || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        bRet = YES;
    }
    return bRet;
}

+ (BOOL)isIP: (NSString *)str {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ipReg];
    BOOL isValid = [predicate evaluateWithObject: str];
    return isValid;
}
+ (BOOL)isInvalidIDFA: (NSString *)str {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", inValidIDFAReg];
    BOOL isValid = [predicate evaluateWithObject: str];
    return isValid;
}

+ (NSDictionary *)dictionaryFromQuery:(NSString *)query {
    NSMutableDictionary *result = [@{} mutableCopy];
    NSArray *array = [query componentsSeparatedByString:@"&"];
    for (NSString *keyValuePairString in array) {
        NSArray *keyValuePairArray = [keyValuePairString componentsSeparatedByString:@"="];
        if ([keyValuePairArray count] < 2) continue;
        
        NSString *key   = [self URLDecodingWithEncodingString:keyValuePairArray[0]];
        NSString *value = [self URLDecodingWithEncodingString:keyValuePairArray[1]];
        NSNumber *value2 = nil;
        if ([self isPureInt: value] || [self isPureFloat: value]) {
            NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
            value2 = [nf numberFromString: value];
            result[key] = value2;
        } else {
            result[key] = value;
        }
        
    }
    
    return result;
}

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)URLDecodingWithEncodingString:(NSString *)encodingString {
    NSMutableString *string = [NSMutableString stringWithString:encodingString];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
