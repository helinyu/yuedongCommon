//
//  MSStringKit.h
//  SportsInternational
//
//  Created by 张旻可 on 15/9/1.
//  Copyright (c) 2015年 yuedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSStringKit : NSObject

+ (NSString *)genUUID;
+ (BOOL)isNetPath: (NSString *)path;
+ (BOOL)isEmptyStr:(NSString*)strCheck;
+ (BOOL)isIP: (NSString *)str;
+ (BOOL)isInvalidIDFA: (NSString *)str;
+ (NSDictionary *)dictionaryFromQuery:(NSString *)query;

@end
