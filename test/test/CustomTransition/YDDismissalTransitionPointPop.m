//
// VTDAddDismissalTransition.m
//
// Copyright (c) 2014 Mutual Mobile (http://www.mutualmobile.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "YDDismissalTransitionPointPop.h"

@implementation YDDismissalTransitionPointPop

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dismissPoint = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        _duration = 0.5f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
	return self.duration;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.2
                     animations:^{
                         CGAffineTransform t0 = CGAffineTransformMakeScale(1.2, 1.2);
                         fromVC.view.transform = t0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.8
                                          animations:^{
                                              containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
                                              CGAffineTransform t1 = CGAffineTransformMakeScale(0.001, 0.001);
                                              fromVC.view.alpha = 0;
                                              fromVC.view.transform = t1;
                                              fromVC.view.center = self.dismissPoint;
                                          } completion:^(BOOL finished) {
                                              [fromVC.view removeFromSuperview];
                                              [transitionContext completeTransition:YES];
                                          }];
                     }];
}

@end
