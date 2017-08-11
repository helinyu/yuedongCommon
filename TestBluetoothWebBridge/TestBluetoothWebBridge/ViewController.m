//
//  ViewController.m
//  TestBluetoothWebBridge
//
//  Created by Aka on 2017/8/11.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <YDBluetoothWebBridge/YDBluetoothWebBridge.h>

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"显示html页面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onTestClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 100);

}

- (void)onTestClicked {
    YDBridgeWebViewController *vc = [[YDBridgeWebViewController alloc] initWithUrl:@"https://m.baidu.com/" andType:YDWebViewTypeInner];
//    [YDBridgeWebViewController new];
//    vc.type = YDWebViewTypeS3;
    vc.urlString = @"http://baidu.com";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
