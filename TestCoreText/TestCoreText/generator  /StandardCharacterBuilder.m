//
//  StandardCharacterBuilder.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "StandardCharacterBuilder.h"

@implementation StandardCharacterBuilder

- (Characterbuilder *)buildStrength:(float)value {
    self.character.protection *= value;
    self.character.power *= value;
    return [super buildStrength:value];
}

- (Characterbuilder *)buildStamina:(float)value {
    self.character.protection *= value;
    self.character.power *= value;
    return [super buildStamina:value];
}

//- (Characterbuilder *)buildNewCharacter;
- (Characterbuilder *)buildIntelligence:(float)value {
    self.character.protection *= value;
    self.character.power /= value;
    return [super buildIntelligence:value];
}

- (Characterbuilder *)buildAgility:(float)value {
    self.character.protection *= value;
    self.character.power /= value;
    return [super buildAgility:value];
}

- (Characterbuilder *)buildAggressveness:(float)value {
    self.character.protection /= value;
    self.character.power *= value;
    return [super buildAggressveness:value];
}

@end
