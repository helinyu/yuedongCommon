//
//  Person.m
//  ivar
//
//  Created by Aka on 2017/8/19.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "Person.h"

@interface Person()

@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name3 = @"name 3 de zhi";
    }
    return self;
}

- (void)test0 {
    NSLog(@"test0");
}

- (void)hah {
    NSLog(@"hah");
}

- (void)test1 {
    NSLog(@"test1");
}

@end