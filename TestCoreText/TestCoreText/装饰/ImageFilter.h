//
//  ImageFilter.h
//  TestCoreText
//
//  Created by Aka on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageComponent.h"

@interface ImageFilter : NSObject <ImageComponent>

@property (nonatomic, retain) id<ImageComponent> component;

- (void)apply;
- (id)initWithImageComponent:(id<ImageComponent>) component;
- (id)forwardingTargetForSelector:(SEL)aSelector;
@end
