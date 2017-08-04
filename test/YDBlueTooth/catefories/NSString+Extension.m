//
//  NSString+Extension.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "NSString+Extension.h"
#import "YDSystem.h"

@implementation NSString (Extension)

- (BOOL)containsString:(NSString *)str {
//    if ([YDSystem isGreaterOrEqualThen8]) {
//        return [self containsString:str];
//    }
    NSRange range = [self rangeOfString:str];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

@end
