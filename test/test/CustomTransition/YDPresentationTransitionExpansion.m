//
//  YDPresentationTransitionExpansion.m
//  SportsBar
//
//  Created by Szythum on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDPresentationTransitionExpansion.h"

static const CGFloat kContainerRadius = 1200.0;
static const CGFloat kMaskAlpha = 0.5;
static const CGFloat kTransitionDuration = 0.4;

@implementation YDPresentationTransitionExpansion

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return kTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:kMaskAlpha];
    [containerView addSubview:toVC.view];
    
    containerView.frame = CGRectMake(0, 0, kContainerRadius, kContainerRadius);
    containerView.center = fromVC.view.center;
    containerView.layer.cornerRadius = kContainerRadius / 2;
    containerView.layer.masksToBounds = YES;
    
    CGAffineTransform scaleFrom = CGAffineTransformMakeScale(0, 0);
    containerView.transform = scaleFrom;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGAffineTransform scaleTo = CGAffineTransformMakeScale(1, 1);
                         containerView.transform = scaleTo;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
