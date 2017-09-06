//
//  DraggableBtnMgr.m
//  YDProgressView
//
//  Created by Aka on 2017/9/6.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "DraggableBtnMgr.h"

@implementation DraggableBtnMgr

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}



@end
