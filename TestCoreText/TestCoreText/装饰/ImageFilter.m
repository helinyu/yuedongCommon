//
//  ImageFilter.m
//  TestCoreText
//
//  Created by Aka on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ImageFilter.h"

@implementation ImageFilter

- (id)initWithImageComponent:(id<ImageComponent>)component {
    if (self = [super init]) {
//        保存ImageComponent
        [self setComponent:component];
    }
    return self;
}

- (void)apply {
//    应该由子类重载，应用真正的滤镜
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *selectorName = NSStringFromSelector(aSelector);
    if ([selectorName hasPrefix:@"draw"]) {
        [self apply];
    }
    return _component;
}

@end
