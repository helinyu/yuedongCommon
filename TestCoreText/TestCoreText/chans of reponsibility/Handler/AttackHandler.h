//
//  AttackHandler.h
//  TestCoreText
//
//  Created by mac on 28/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Attack;

@interface AttackHandler : NSObject

@property (strong, nonatomic) AttackHandler *nextHandler;

- (void)handlerAttack:(Attack *)attack;

@end
