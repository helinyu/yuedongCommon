//
//  VCNavPushingTransitionAnimator.m
//  test
//
//  Created by felix on 2017/5/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "VCNavTransitionAnimator.h"
#import "UIViewController+WTKAnimationTransitioningSnapshot.h"

@implementation VCNavTransitionAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromVC.view;
        toView = fromVC.view;
    }
    
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    
    fromView.alpha = 1.0f;
    toView.alpha = 0.0f;
    
    [containerView addSubview:fromVC.snapshot];
    [containerView addSubview:toVC.view];
    [[toVC.navigationController.view superview] insertSubview:fromVC.snapshot belowSubview:toVC.navigationController.view];
    
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        fromView.alpha = 0.0f;
        toView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:YES];
        });
    }];
}

- (void)animationEnded:(BOOL) transitionCompleted {
    NSLog(@"动画完成");
}


@end
