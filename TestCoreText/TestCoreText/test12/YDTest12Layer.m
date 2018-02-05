//
//  YDTest12Layer.m
//  TestCoreText
//
//  Created by mac on 5/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest12Layer.h"

@interface YDTest12Layer ()<CALayerDelegate>
{
    id _target;
    SEL _sel;
}

@end

@implementation YDTest12Layer

- (instancetype)init {
    self = [super init];
    if(self) {
        self.delegate = self;
    }
    return self;
}

// 只是设置了touch up inside
- (void)addTarget:(nullable id)target action:(ActionBlock)action {
    _target = target;
    if (action == NULL) {
        NSLog(@"必须输入方法");
        return;
    }
    _actionBlock = action;
}

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    NSLog(@"delegate for self layer:%@; event:%@",layer,event);
    if ([event isEqualToString:@"backgroundColor"]) {
        
    }
    else if ([event isEqualToString:@"position"]) {
        
    }
    else if ([event isEqualToString:@"bounds"]) {
        
    }
    else if ([event isEqualToString:@"delegate"]) {
        !_actionBlock? :_actionBlock(layer, event);
    }
    else {
        NSLog(@"other s");
    }
    return nil;
}

@end
