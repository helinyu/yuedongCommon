//
//  YDDefaultCss.m
//  TestCoreText
//
//  Created by mac on 8/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDDefaultCss.h"

@implementation YDDefaultCss


+ (instancetype)shared {
    static YDDefaultCss *cssObj = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!cssObj) {
            cssObj = [[self alloc] init];
        }
    });
    return cssObj;
}

@end
