//
//  LYBlockPerson2.m
//  test
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "LYBlockPerson2.h"

@implementation LYBlockPerson2

- (LYBlockPerson2 * (^)(NSString *name))study {
    return ^(NSString *name) {
        NSLog(@"study ---- %@",name);
        return self;
    };
}

- (LYBlockPerson2 * (^)(void))run {
    return ^(void){
        NSLog(@"run ----");
        return self;
    };
}

@end
