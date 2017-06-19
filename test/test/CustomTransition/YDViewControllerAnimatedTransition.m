//
//  YDViewControllerAnimatedTransition.m
//  SportsBar
//
//  Created by Szythum on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDViewControllerAnimatedTransition.h"

#import "YDPresentationTransitionDownSpring.h"
#import "YDDismissalTransitionDownSpring.h"
#import "YDPresentationTransitionExpansion.h"
#import "YDDismissalTransitionExpansion.h"
#import "YDPresentationTransitionPointPop.h"
#import "YDDismissalTransitionPointPop.h"

@implementation YDViewControllerAnimatedTransition

+ (id)transitionWithType:(ViewControllerTransitionType)type style:(ViewControllerTransitionStyle)style {
    if (type == ViewControllerTransitionTypePresentation) {
        switch (style) {
            case ViewControllerTransitionStyleDownSpring:
                return [[YDPresentationTransitionDownSpring alloc] init];
            case ViewControllerTransitionStyleExpansion:
                return [[YDPresentationTransitionExpansion alloc] init];
            case ViewControllerTransitionStylePointPop:
                return [[YDPresentationTransitionPointPop alloc] init];
            default:
                return nil;
        }
    }
    
    if (type == ViewControllerTransitionTypeDismissal) {
        switch (style) {
            case ViewControllerTransitionStyleDownSpring:
                return [[YDDismissalTransitionDownSpring alloc] init];
            case ViewControllerTransitionStyleExpansion:
                return [[YDDismissalTransitionExpansion alloc] init];
            case ViewControllerTransitionStylePointPop:
                return [[YDDismissalTransitionPointPop alloc] init];
            default:
                return nil;
        }
    } else {
        return nil;
    }
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
}


@end
