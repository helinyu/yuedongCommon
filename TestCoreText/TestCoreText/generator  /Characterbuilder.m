//
//  Characterbuilder.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Characterbuilder.h"

@implementation Characterbuilder

- (Characterbuilder *)buildNewCharacter {
    _character = [Character new];
    return self;
}

- (Characterbuilder *)buildStrength:(float)value {
    _character.strength = value;
    return self;
}

- (Characterbuilder *)buildStamina:(float)value {
    _character.stamina = value;
    return self;
}

- (Characterbuilder *)buildIntelligence:(float)value {
    _character.intelligence = value;
    return self;
}

- (Characterbuilder *)buildAgility:(float)value {
    _character.agility = value;
    return self;
}

- (Characterbuilder *)buildAggressveness:(float)value {
    _character.agressiveness = value;
    return self;
}

@end
