//
//  Characterbuilder.h
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@interface Characterbuilder : NSObject

@property (nonatomic, strong) Character *character;

- (Characterbuilder *)buildNewCharacter;
- (Characterbuilder *)buildStrength:(float)value;
- (Characterbuilder *)buildStamina:(float)value;
- (Characterbuilder *)buildIntelligence:(float)value;
- (Characterbuilder *)buildAgility:(float)value;
- (Characterbuilder *)buildAggressveness:(float)value;

@end
