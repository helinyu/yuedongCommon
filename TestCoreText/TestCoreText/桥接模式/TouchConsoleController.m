//
//  TouchConsoleController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/27.
//  Copyright © 2018年 mac. All rights reserved

#import "TouchConsoleController.h"

@implementation TouchConsoleController

- (void)up {
    [super setCommand:kConsoleCommandUp];
}

- (void)down {
    [super setCommand:kConsoleCommnadDown];

}

- (void)left {
    [super setCommand:kConsoleCommnadLeft];

}

- (void)right {
    [super setCommand:kConsoleCommnadRight];

}

- (void)select {
    [super setCommand:kConsoleCommnadSelect];
}

- (void)start {
    [super setCommand:kConsoleCommnadStart];
}

- (void)aciton1 {
    [super setCommand:kConsoleCommnadActoin1];
}

- (void)action2 {
    [super setCommand:kConsoleCommnadAction2];
}

@end
