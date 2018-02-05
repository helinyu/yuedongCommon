//
//  YDTest12Layer.h
//  TestCoreText
//
//  Created by mac on 5/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface YDTest12Layer : CALayer

typedef void (^ActionBlock)(CALayer *layer, NSString *event);
@property (nonatomic, copy) ActionBlock actionBlock;
- (void)addTarget:(nullable id)target action:(ActionBlock)action;

@end
