//
//  YDTest1q6ViewController.m
//  TestCoreText
//
//  Created by mac on 7/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest1q6ViewController.h"
#import "YDTest16Label.h"

@interface YDTest1q6ViewController ()

@property (nonatomic, strong) YDTest16Label *testlabel;

@end

@implementation YDTest1q6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testlabel = [YDTest16Label new];
    [self.view addSubview:_testlabel];
    _testlabel.numberOfLines = 0;
    _testlabel.backgroundColor = [UIColor yellowColor];
    _testlabel.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
    _testlabel.text = @"sdkfasadjfkla;jsdfkljjskdfj";
    [_testlabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
