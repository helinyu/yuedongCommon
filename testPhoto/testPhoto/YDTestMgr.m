//
//  YDTestMgr.m
//  testPhoto
//
//  Created by mac on 29/12/17.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDTestMgr.h"

@implementation YDTestMgr

static YDTestMgr *manager;
static dispatch_once_t onceToken;

+ (instancetype)manager {
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (void)test0 {
    NSLog(@"test 0");
}

@end
