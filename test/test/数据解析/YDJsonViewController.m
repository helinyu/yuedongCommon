//
//  YDJsonViewController.m
//  test
//
//  Created by felix on 2017/6/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDJsonViewController.h"

@implementation YDJsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *lastString = @"asjfdajskfj;;;";
    NSString *searchString = @";;;,";
    NSRange range = [lastString rangeOfString:searchString options:NSRegularExpressionSearch];
    NSLog(@"ranage : %lu,%lu",(unsigned long)range.length,(unsigned long)range.location);
}

@end
