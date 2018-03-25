//
//  ChasingGame.h
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardCharacterBuilder.h"
@class Character;

@interface ChasingGame : NSObject

- (Character *)createPlayer:(Characterbuilder *)bulder;
- (Character *)createEnemy:(Characterbuilder *)builder;

@end
