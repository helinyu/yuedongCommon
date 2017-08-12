//
//  ViewController.m
//  test_project
//
//  Created by Aka on 2017/8/12.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "Test1ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	Test1ViewController *vc = [Test1ViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
