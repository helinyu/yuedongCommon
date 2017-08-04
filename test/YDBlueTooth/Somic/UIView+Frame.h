//
//  UIView+Frame.h
//  YDOpenHardwareThirdPart
//
//  Created by mac-somic on 2017/4/16.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Frame)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) setTop: (CGFloat) newtop;

- (void)moveBy:(CGPoint) delta;
- (void)scaleBy:(CGFloat) scaleFactor;
- (void)fitInSize:(CGSize) aSize;

@end
