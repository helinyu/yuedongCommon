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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoadHtmlNotify:) name:@"yd.ntf.load.outside.bundle.html" object:nil];

}

- (void)onTestClicked {
////        YDBridgeWebViewController *vc = [[YDBridgeWebViewController alloc] initWithUrl:@"https://www.baidu.com/" andType:YDWebViewTypeInner];
//        YDBridgeWebViewController *vc = [[YDBridgeWebViewController alloc] initWithUrl:@"http://192.168.11.127:8000/S3.html" andType:YDWebViewTypeS3];
////    YDBridgeWebViewController *vc = [YDBridgeWebViewController new];
////    vc.urlString = @"S3.html";
////    vc.type = YDWebViewTypeS3;
//    [self.navigationController pushViewController:vc animated:YES];
//}
    
    //   load html string
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"S3.html" ofType:nil];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    YDBridgeWebViewController *vc = [YDBridgeWebViewController new];
    vc.urlString = htmlString;
    vc.type = YDWebViewTypeS3;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)onLoadHtmlNotify:(NSNotification *)noti {
    NSString *urlString = noti.object;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:urlString ofType:nil];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yd.readload.html" object:htmlString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
