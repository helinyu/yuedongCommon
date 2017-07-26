//
//  ViewController.m
//  YDJavascriptBridge
//
//  Created by Aka on 2017/7/26.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "YDJavascriptBridge.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

//@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) YDJavascriptBridge *bridge;

@property (nonatomic, strong) UIButton *webViewBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    configuration.preferences.minimumFontSize = 18.f;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/2.f) configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;

    [self.view addSubview:_webView];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"wkBridge.html" ofType:nil];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [_webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
  
    WKUserContentController *userCC = configuration.userContentController;
    [userCC addScriptMessageHandler:self name:@"showName"];
    
    _webViewBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_webViewBtn];
    [_webViewBtn setTitle:@"web btn" forState:UIControlStateNormal];
    _webViewBtn.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)/2, 100, 30);
    [_webViewBtn addTarget:self action:@selector(onWebviewClicked) forControlEvents:UIControlEventTouchUpInside];

    [self responseBlock];
}

- (void)responseBlock {
    
    _bridge = [YDJavascriptBridge bridgeWithWKWebView:_webView];
   
    [_bridge registerMethod:@"showMoreParam" complete:^(NSDictionary *responseDic) {
        NSLog(@"dic : %@",responseDic);
    }];
   
    [_bridge registerMethodNoDatasCallback:@"showNOParam" complete:^{
        NSLog(@"no data callback");
    }];
    
}

- (void)onWebviewClicked {
//    [_bridge evaluateScript:@"onshow()"];
    [self.webView evaluateJavaScript:@"alertSendMsg('18870707070','周末爬山真是件愉快的事情')" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@ %@",response,error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"didReceiveScriptMessage");
}



- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        !decisionHandler?:decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        !decisionHandler?:decisionHandler(WKNavigationActionPolicyAllow);
    }
}

@end
