//
//  ScribbleMemento.h
//  TestCoreText
//
//  Created by Aka on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

@interface ScribbleMemento : NSObject<NSCoding>

@property (nonatomic, assign) id<Mark> mark;
@property (nonatomic, assign) BOOL hasCompleteSnapshot;

- (ScribbleMemento *)metaWithData:(NSData *)data;
- (NSData *)data;

@end
