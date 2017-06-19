//
// VTDAddPresentationTransition.m
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

#import "YDPresentationTransitionDownSpring.h"

@implementation YDPresentationTransitionDownSpring

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return 1.5f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
	UIView *containerView = [transitionContext containerView];
    //[containerView addSubview:fromVC.view];
    containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
	[containerView addSubview:toVC.view];
    
//    CGRect toViewFrame = CGRectMake(0.0f, 0.0f, 260.0f, 300.0f);
    toVC.view.frame = SCREEN_BOUNDS;
    
    CGPoint finalCenter = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    toVC.view.center = CGPointMake(finalCenter.x, finalCenter.y - SCREEN_WIDTH);

	[UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.64f
          initialSpringVelocity:0.22f
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         toVC.view.center = finalCenter;
                     } completion:^(BOOL finished) {
//                             toVC.view.center = finalCenter;
                        [transitionContext completeTransition:YES];
                     }];
}

@end
