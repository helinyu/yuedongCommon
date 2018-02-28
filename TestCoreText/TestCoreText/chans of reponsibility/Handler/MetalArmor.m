//
//  MetalArmor.m
//  TestCoreText
//
//  Created by mac on 28/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MetalArmor.h"
#import "SwordAttack.h"

@implementation MetalArmor

- (void)handlerAttack:(Attack *)attack {
    if ([attack isKindOfClass:[SwordAttack class]]) {
        NSLog(@"no damage from a sword attack");
    }
    else {
        NSLog(@"MetalArmor do not know");
        [super handlerAttack:attack];
    }
}

@end
