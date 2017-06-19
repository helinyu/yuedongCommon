//
//  YDFadeDismisalTransition.m
//  SportsBar
//
//  Created by Szythum on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDDismissalTransitionExpansion.h"

static const CGFloat kTransitionDuration = 0.25;

@implementation YDDismissalTransitionExpansion

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return kTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        containerView.alpha = 0;
    }completion:^(BOOL finished) {
        if (finished) {
            [fromVC.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }
    }];
}

@end
