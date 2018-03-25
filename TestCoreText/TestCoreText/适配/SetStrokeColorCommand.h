//
//  SetStrokeColorCommand.h
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Command.h"

@class SetStrokeColorCommand;

@protocol SetStrokeColorCommandDelegate

- (void)command:(SetStrokeColorCommand *)command
didRequestColorComponentsForRed:(CGFloat *)red
          green:(CGFloat *)green
           blue:(CGFloat *)blue;

@end

@interface SetStrokeColorCommand :Command

@property (nonatomic, assign) id<SetStrokeColorCommandDelegate> delegate;

- (void)execute;

@end
