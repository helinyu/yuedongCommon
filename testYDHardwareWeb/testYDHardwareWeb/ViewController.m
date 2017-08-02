//
//  ViewController.m
//  testYDHardwareWeb
//
//  Created by Aka on 2017/8/2.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDBridgeWebViewController.h"
#import "YDBridgeWebMgr.h"
#import "YDBridgeWebView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"网页展示" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 30);
    [btn addTarget:self action:@selector(toWebVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)toWebVC {
    YDBridgeWebViewController *vc = [YDBridgeWebViewController new];
    vc.urlString = @"S3.html";
    vc.type = YDWebViewTypeS3;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
