//
//  YDControllerAnimationMgr.h
//  SportsBar
//
//  Created by 卓名杰 on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDViewControllerAnimatedTransition.h"
@class YDNavigationController;

@interface YDControllerAnimationMgr : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) ViewControllerTransitionStyle animStyle;
@property (nonatomic, weak) YDNavigationController *nav;

+ (YDControllerAnimationMgr *)shareMgr;

@property (nonatomic, strong) YDViewControllerAnimatedTransition *preTs;
@property (nonatomic, strong) YDViewControllerAnimatedTransition *disTs;

@end
