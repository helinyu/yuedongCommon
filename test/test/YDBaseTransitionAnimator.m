//
//  YDBaseTransitionAnimator.m
//  SportsBar
//
//  Created by felix on 2017/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDBaseTransitionAnimator.h"


@interface YDBaseTransitionAnimator()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation YDBaseTransitionAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    return 0.1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
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
    
    fromView.alpha = 0.0f;
    toView.alpha = 1.0f;
    
    [containerView addSubview:toView];
    [fromView removeFromSuperview];
    
}

- (void)animationEnded:(BOOL)transitionCompleted {
    if(transitionCompleted) {
         [self.transitionContext completeTransition:YES];
    }
}

@end
