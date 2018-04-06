//
//  ConsoleController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ConsoleController.h"

@implementation ConsoleController

- (void)setCommand:(ConsoleCommand) command {
    [_emulator loadInstructsForCommand:command];
    [_emulator executeInstructions];
}

@end
