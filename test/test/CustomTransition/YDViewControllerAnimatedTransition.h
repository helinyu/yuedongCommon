//
//  YDViewControllerAnimatedTransition.h
//  SportsBar
//
//  Created by Szythum on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 *  抽象基类, 使用其子类并实现要求的方法
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewControllerTransitionType) {
    ViewControllerTransitionTypePresentation,
    ViewControllerTransitionTypeDismissal
};

typedef NS_ENUM(NSInteger, ViewControllerTransitionStyle) {
    ViewControllerTransitionStyleDownSpring,
    ViewControllerTransitionStyleExpansion,
    ViewControllerTransitionStylePointPop
};

@interface YDViewControllerAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

// 子类需实现以下两个方法
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext __attribute__((unavailable("")));
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext __attribute__((unavailable("")));

+ (id)transitionWithType:(ViewControllerTransitionType)type style:(ViewControllerTransitionStyle)style;

@end
