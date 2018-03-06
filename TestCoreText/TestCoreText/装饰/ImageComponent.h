//
//  ImageComponent.h
//  TestCoreText
//
//  Created by Aka on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageComponent <NSObject>
@optional
- (void)drawAsPatternInRect:(CGRect)rect;
- (void)drawAtPoint:(CGPoint)point;
- (void)drawAtPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

- (void)drawInRect:(CGRect)rect;
- (void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end
