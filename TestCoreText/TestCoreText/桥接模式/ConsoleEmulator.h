//
//  ConsoleEmulator.h
//  TestCoreText
//
//  Created by Aka on 2018/3/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsoleCommand.h"

@interface ConsoleEmulator : NSObject

- (void)loadInstructsForCommand:(ConsoleCommand)command;
- (void)executeInstructions;

//其他行为和属性

@end
