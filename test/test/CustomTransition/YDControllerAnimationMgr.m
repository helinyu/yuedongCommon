//
//  YDControllerAnimationMgr.m
//  SportsBar
//
//  Created by 卓名杰 on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "YDControllerAnimationMgr.h"
#import "YDNavigationController.h"

@implementation YDControllerAnimationMgr

static YDControllerAnimationMgr *single;

+ (YDControllerAnimationMgr *)shareMgr{
    if (single == nil) {
        single = [[self alloc] init];
    }
    return single;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.disTs && self.animStyle == ViewControllerTransitionStylePointPop) {
        return self.disTs;
    }
    return [YDViewControllerAnimatedTransition transitionWithType:ViewControllerTransitionTypeDismissal style:self.animStyle];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    if (self.preTs && self.animStyle == ViewControllerTransitionStylePointPop) {
        return self.preTs;
    }
    return [YDViewControllerAnimatedTransition transitionWithType:ViewControllerTransitionTypePresentation style:self.animStyle];
}


@end
