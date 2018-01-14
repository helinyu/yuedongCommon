//
//  Aurora.swift
//  Aurora
//
//  Created by Andrew Aquino on 7/2/16.
//  Copyright © 2016 Andrew Aquino. All rights reserved.
//

import Foundation
import UIKit

public class Aurora: UIPercentDrivenInteractiveTransition, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
  
  public enum AnimationType {
    case Present
    case Dismiss
  }
  
  public enum AnimationState {
    case BeforeAll
    case Animate
    case AfterAll
  }
  
  private weak var transitionContext: UIViewControllerContextTransitioning?
  
  public var animationRatio: CGFloat = 0.0
  public var animationDuration: NSTimeInterval = 0.7
  public var delay: NSTimeInterval = 0.0
  public var springDamping: CGFloat = 0.6
  public var springVelocity: CGFloat = 0.8
  public var phaseTwoAnimationDuration: NSTimeInterval = 1.0
  public var isPresenting: Bool = true
  
  public convenience init(
    animationDuration: NSTimeInterval,
    springDamping: CGFloat = 0.6,
    springVelocity: CGFloat = 1.0,
    fromViewController: UIViewController? = nil,
    toViewController: UIViewController? = nil
    ) {
    self.init()
    
    self.animationDuration = animationDuration
    self.springDamping = springDamping
    self.springVelocity = springVelocity
    
    toViewController?.transitioningDelegate = self
    fromViewController?.navigationController?.delegate = self
  }
  
  deinit {
    transitionContext = nil
  }
  
  public var animationPresentationBeforeAllHandler: ((containerView: UIView, fromView: UIView, toView: UIView) -> Void)?
  public var animationPresentationAnimationHandler: ((containerView: UIView, fromView: UIView, toView: UIView) -> Void)?
  public var animationPresentationAfterAllHandler: ((containerView: UIView, fromView: UIView, toView: UIView) -> Void)?
  
  public var animationDismissalBeforeAllHandler: ((containerView: UIView, fromView: UIView, toView: UIView) -> Void)?
  public var animationDismissalAnimationHandler: ((containerView: UIView, fromView: UIView, toView: UIView) -> Void)?
  public var animationDismissalAfterAllHandler: ((containerView: UIView, fromView: UIView, toView: UIView) -> Void)?
  
  // MARK: UIViewControllerTransitioningDelegate
  
  public weak var fromVC: UIViewController?
  public weak var toVC: UIViewController?
  
  public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.fromVC = source
    self.toVC = presented
    isPresenting = true
    return self
  }
  
  public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresenting = false
    return self
  }
  
  public func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return nil
  }
  
  public func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return nil
  }
  
  // MARK: UIViewControllerAnimatedTransitioning
  
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 1.0
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    self.transitionContext = transitionContext
    
    executeAnimation()
  }
  
  // MARK: Navigation Controller
  
  public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    self.toVC = toVC
    self.fromVC = fromVC
    
    switch operation {
    case .Push:
      isPresenting = true
      return self
    case .Pop:
      isPresenting = false
      return self
    case .None:
      return nil
    }
  }
  
  // MARK: Animation Methods
  
  public func executeAnimation() {
    if
      let transitionContext = transitionContext,
      let containerView = transitionContext.containerView(),
      let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
      let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
    {
      
      fromView.removeFromSuperview()
      toView.removeFromSuperview()
      
      containerView.addSubview(fromView)
      containerView.addSubview(toView)
      
      let animationType: AnimationType = isPresenting ? .Present : .Dismiss
      
      executeAnimation(animationType, animationState: .BeforeAll)
      executeAnimation(animationType, animationState: .Animate) { [weak self] in
        self?.executeAnimation(animationType, animationState: .AfterAll) { [weak self] in
          transitionContext.completeTransition(true)
        }
      }
    } else {
      transitionContext?.completeTransition(true)
    }
  }
  
  public func executeAnimation(animationType: AnimationType, animationState: AnimationState, completionHandler: (() -> Void)? = nil) {
    if
      let transitionContext = transitionContext,
      let containerView = transitionContext.containerView(),
      let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
      let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
    {
      
      switch animationType {
      case .Present:
        switch animationState {
        case .BeforeAll:
          animationPresentationBeforeAllHandler?(
            containerView: containerView,
            fromView: fromView,
            toView: toView
          )
          completionHandler?()
          break
        case .Animate:
          if let block = animationPresentationAnimationHandler {
            UIView.animateWithDuration(animationDuration, delay: delay, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: .CurveEaseInOut, animations: {
              block(
                containerView: containerView,
                fromView: fromView,
                toView: toView
              )
            }) { bool in
              completionHandler?()
            }
          } else {
            completionHandler?()
          }
          break
        case .AfterAll:
          animationPresentationBeforeAllHandler?(
            containerView: containerView,
            fromView: fromView,
            toView: toView
          )
          completionHandler?()
          break
        }
        break
      case .Dismiss:
        switch animationState {
        case .BeforeAll:
          animationDismissalBeforeAllHandler?(
            containerView: containerView,
            fromView: fromView,
            toView: toView
          )
          completionHandler?()
          break
        case .Animate:
          if let block = animationDismissalAnimationHandler {
            UIView.animateWithDuration(animationDuration, delay: delay, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: .CurveEaseInOut, animations: {
              block(
                containerView: containerView,
                fromView: fromView,
                toView: toView
              )
            }) { bool in
              completionHandler?()
            }
          } else {
            completionHandler?()
          }
          break
        case .AfterAll:
          animationDismissalAfterAllHandler?(
            containerView: containerView,
            fromView: fromView,
            toView: toView
          )
          completionHandler?()
          break
        }
      }
    }
  }
}