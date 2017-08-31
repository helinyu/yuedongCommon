//
//  ViewController.m
//  TestAlertWindow
//
//  Created by Aka on 2017/8/31.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *alertViewOverWindow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _alertViewOverWindow = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 200, 80)];
    _alertViewOverWindow.backgroundColor = [UIColor yellowColor];
//    [ addSubview:_alertViewOverWindow];
    
    UIWindow *keywindow = [UIApplication sharedApplication].windows.lastObject;
    keywindow.backgroundColor = [UIColor blueColor];
//    [keywindow addSubview:_alertViewOverWindow];
    [keywindow insertSubview:_alertViewOverWindow aboveSubview:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
