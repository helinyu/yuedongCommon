//
//  ViewController.m
//  YDJavascriptBridge
//
//  Created by Aka on 2017/7/26.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "YDJavascriptBridge.h"

@interface ViewController ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) YDJavascriptBridge *bridge;

@property (nonatomic, strong) UIButton *webViewBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/2.f)];
    [self.view addSubview:_webView];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bridge.html" ofType:nil];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [_webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
  
    _webViewBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_webViewBtn];
    [_webViewBtn setTitle:@"web btn" forState:UIControlStateNormal];
    _webViewBtn.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)/2, 100, 30);
    [_webViewBtn addTarget:self action:@selector(onWebviewClicked) forControlEvents:UIControlEventTouchUpInside];

    [self responseBlock];
}

- (void)responseBlock {
    
    _bridge = [YDJavascriptBridge bridgeWithUIWebview:_webView];
   
    [_bridge registerMethod:@"showMoreParam" complete:^(NSDictionary *responseDic) {
        NSLog(@"dic : %@",responseDic);
    }];
   
    [_bridge registerMethodNoDatasCallback:@"showNOParam" complete:^{
        NSLog(@"no data callback");
    }];
    
}

- (void)onWebviewClicked {
    [_bridge evaluateScript:@"onshow()"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
