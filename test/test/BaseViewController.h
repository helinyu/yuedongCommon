//
//  BaseViewController.h
//  test
//
//  Created by felix on 2017/5/22.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

#pragma mark - init method

/**
 *  create subviews
 */
- (void)msComInit;
/**
 *  create constraints
 */
- (void)createViewConstraints;
/**
 *  notification bind & touch events bind & delegate bind
 */
- (void)msBind;
/**
 *  data init
 */
- (void)msDataInit;
/**
 *  static style
 */
- (void)msStyleInit;
/**
 *  language init
 */
- (void)msLangInit;


@end
