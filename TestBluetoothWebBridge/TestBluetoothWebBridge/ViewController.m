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
//        YDBridgeWebViewController *vc = [[YDBridgeWebViewController alloc] initWithUrl:@"https://www.baidu.com/" andType:YDWebViewTypeInner];
        YDBridgeWebViewController *vc = [[YDBridgeWebViewController alloc] initWithUrl:@"http://192.168.11.127:8000/S3.html" andType:YDWebViewTypeS3];
//    YDBridgeWebViewController *vc = [YDBridgeWebViewController new];
//    vc.urlString = @"S3.html";
//    vc.type = YDWebViewTypeS3;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
