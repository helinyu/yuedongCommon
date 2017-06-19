//
//  MainPageViewController.m
//  test
//
//  Created by felix on 2017/5/22.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "MeMainViewController.h"

@interface MeMainViewController ()

@end

@implementation MeMainViewController

#pragma mark - property init

#pragma mark - initialize and dealloc

#pragma mark - framework init

/**
 *  create subviews
 */
- (void)msComInit {
    
    [super msComInit];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self createViewConstraints];
}

/**
 *  create constraints
 */
- (void)createViewConstraints {
    // ...
    
    [super createViewConstraints];
}

/**
 *  notification bind & touch events bind & delegate bind
 */
- (void)msBind {
    [super msBind];
}

/**
 *  data init
 */
- (void)msDataInit {
    [super msDataInit];
}

/**
 *  static style
 */
- (void)msStyleInit {
    [super msStyleInit];
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 *  language init
 */
- (void)msLangInit {
    [super msLangInit];
    
}

- (void)testNavigationBar {
    self.navigationItem.title = MeMainText;
    //    [self.navigationController.navigationBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"second"] animated:YES];
    //    [self.navigationController.navigationBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"third"] animated:YES];
    //    这个都是对back的item的view进行设置  （这个还不知道有什么需求的饿作用）
    self.navigationController.navigationBar.frame = CGRectMake(0, 0,SCREEN_WIDTH ,200);
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self testNavigationBar];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);

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
