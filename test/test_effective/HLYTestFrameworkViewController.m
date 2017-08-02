//
//  HLYTestFrameworkViewController.m
//  test
//
//  Created by Aka on 2017/8/2.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYTestFrameworkViewController.h"
#import <TestAKA/TestAKA.h>

@interface HLYTestFrameworkViewController ()

@end

@implementation HLYTestFrameworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger result = [AKAFrameworkTest addWithFirstNumber:10 number2:2];
    NSLog(@"reulst %ld",(long)result);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
