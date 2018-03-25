//
//  ChasingGame.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChasingGame.h"

@implementation ChasingGame

- (Character *)createPlayer:(Characterbuilder *)bulder {
    [bulder buildNewCharacter];
    [bulder buildStamina:50.f];
    [bulder buildStamina:25.f];
    [bulder buildIntelligence:75.f];
    [bulder buildAggressveness:35.f];
    return [bulder character];
}

- (Character *)createEnemy:(Characterbuilder *)builder {
    [builder buildNewCharacter];
    [builder buildStrength:80.f];
    [builder buildStamina:65.f];
    [builder buildAgility:95.f];
    [builder buildIntelligence:35.f];
    [builder buildAggressveness:95.f];
    return [builder character];
}

@end
