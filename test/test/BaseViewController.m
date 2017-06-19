//
//  BaseViewController.m
//  test
//
//  Created by felix on 2017/5/22.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - property init

#pragma mark - initialize and dealloc

#pragma mark - framework init

/**
 *  create subviews
 */
- (void)msComInit {
    
    [self configureNavigationBar];
    
    [self createViewConstraints];
}

- (void)configureNavigationBar {
    
}
/**
 *  create constraints
 */
- (void)createViewConstraints {
    // ...
    
}

/**
 *  notification bind & touch events bind & delegate bind
 */
- (void)msBind {
}

/**
 *  data init
 */
- (void)msDataInit {
    
}

/**
 *  static style
 */
- (void)msStyleInit {

}

/**
 *  language init
 */
- (void)msLangInit {
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self msComInit];
    [self msBind];
    [self msDataInit];
    [self msStyleInit];
    [self msLangInit];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self net_checkShareReward];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - override

#pragma mark - custom function

#pragma mark - event action

#pragma mark - network request

#pragma mark - network notification

#pragma mark - delegate

@end
