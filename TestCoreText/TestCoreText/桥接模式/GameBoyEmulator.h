//
//  GameBoyEmulator.h
//  TestCoreText
//
//  Created by Aka on 2018/3/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ConsoleEmulator.h"

@interface GameBoyEmulator : ConsoleEmulator

- (void)loadInstructsForCommand:(ConsoleCommand)command;
- (void)executeInstructions;

@end
