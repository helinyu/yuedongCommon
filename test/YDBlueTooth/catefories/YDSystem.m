//
//  System.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDSystem.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation YDSystem

+ (BOOL)isGreaterOrEqualThen8 {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.f) {
        return YES;
    }
    return NO;
}

@end
