//
//  YDNavigationController.m
//  test
//
//  Created by felix on 2017/5/27.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDNavigationController.h"

@interface YDNavigationController ()

@end

@implementation YDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self msInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark orientation
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}
// Returns interface orientation masks.
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return [self.topViewController shouldAutorotateToInterfaceOrientation: toInterfaceOrientation];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return ![self.topViewController isEqual: self.childViewControllers.firstObject];
}

- (void)msInit {
    [self.navigationBar setHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
}



@end
