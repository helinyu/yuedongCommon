//
//  TestPageViewController.m
//  test
//
//  Created by felix on 2017/5/8.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "TestPageViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface TestPageViewController () <TYPagerControllerDataSource,TYPagerControllerDelegate>

@end

@implementation TestPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfControllersInPagerController {
    return 2;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index {
    if (index== 0) {
        return [FirstViewController new];
    }else{
        return [SecondViewController new];
    }

}

- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"title %ld",(long)index];
}

@end
