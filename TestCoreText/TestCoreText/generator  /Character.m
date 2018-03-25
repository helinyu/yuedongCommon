//
//  Character.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Character.h"

@implementation Character

- (instancetype)init
{
    self = [super init];
    if (self) {
        _protection = 1.f;
        _power = 1.f;
        _strength = 1.f;
        _stamina = 1.f;
        _intelligence = 1.f;
        _agility = 1.f;
        _agressiveness = 1.f;
    }
    return self;
}

@end
