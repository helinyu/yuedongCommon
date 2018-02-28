//
//  CrystalShield.m
//  TestCoreText
//
//  Created by mac on 28/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CrystalShield.h"
#import "MaginfireAttack.h"

@implementation CrystalShield

- (void)handlerAttack:(Attack *)attack {
    if ([attack isKindOfClass:[MaginfireAttack class]]) {
        NSLog(@"no damage from a MaginfireAttack");
    }
    else {
        NSLog(@"CrystalShield do not know");
        [super handlerAttack:attack];
    }
}

@end
