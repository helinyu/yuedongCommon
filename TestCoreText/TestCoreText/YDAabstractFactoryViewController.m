//
//  YDAabstractFactoryViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDAabstractFactoryViewController.h"
#import "BrandingFactory.h"

@interface YDAabstractFactoryViewController ()

@end

@implementation YDAabstractFactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BrandingFactory *factory = [BrandingFactory new];
    UIView *view = [factory brandedView];
    UIButton *button = [factory brandedMainButton];
    UIToolbar *toolbar = [factory brandedToolbar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
