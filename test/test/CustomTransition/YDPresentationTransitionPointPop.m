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

#import "YDPresentationTransitionPointPop.h"

@implementation YDPresentationTransitionPointPop

- (instancetype)init {
    self = [super init];
    if (self) {
        _startPos = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        _endPos = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        _duration = 1.0f;
        _startScale = 0.0f;
        _endScale = 1.0f;
    }
    return self;
}

- (void)setDuration:(NSTimeInterval)duration {
    if (duration < 0) {
        _duration = 0;
        return;
    }
    _duration = duration;
}

- (void)setStartScale:(CGFloat)startScale {
    if (startScale < 0) {
        _startScale = 0;
        return;
    }
    _startScale = startScale;
}

- (void)setEndScale:(CGFloat)endScale {
    if (endScale < 0) {
        _endScale = 0;
    }
    _endScale = endScale;
}


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
	return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
	UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
	[containerView addSubview:toVC.view];
    toVC.view.frame = SCREEN_BOUNDS;
    
    CGAffineTransform t0 = CGAffineTransformMakeScale(self.startScale, self.startScale);
    toVC.view.transform = t0;
    toVC.view.center = self.startPos;
    toVC.view.alpha = 0.0;
    
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.8f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         toVC.view.alpha = 1.0;
                         toVC.view.center = self.endPos;
                         toVC.view.transform = CGAffineTransformMakeScale(self.endScale, self.endScale);
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [transitionContext completeTransition:YES];
                         }
                     }];

//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         toVC.view.center = self.endPos;
//                         toVC.view.transform = CGAffineTransformMakeScale(self.endScale, self.endScale);
//                     } completion:^(BOOL finished) {
//                         [transitionContext completeTransition:YES];
//                     }];
}

@end
