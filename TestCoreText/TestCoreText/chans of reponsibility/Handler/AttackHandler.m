//
//  AttackHandler.m
//  TestCoreText
//
//  Created by mac on 28/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AttackHandler.h"
#import "Attack.h"

@interface AttackHandler ()


@end

@implementation AttackHandler

- (void)handlerAttack:(Attack *)attack {
    [_nextHandler handlerAttack:attack];
}

@end
