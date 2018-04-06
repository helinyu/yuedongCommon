//
//  ConsoleController.h
//  TestCoreText
//
//  Created by Aka on 2018/3/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsoleEmulator.h"
#import "ConsoleCommand.h"

@interface ConsoleController : NSObject

@property (nonatomic, retain) ConsoleEmulator *emulator;
- (void)setCommand:(ConsoleCommand) command;

@end
