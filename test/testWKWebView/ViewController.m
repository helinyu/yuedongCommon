//
//  ViewController.m
//  testWKWebView
//
//  Created by Aka on 2017/7/24.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSString *urlString;

@property (nonatomic, strong) UIButton *noneBtn;
@property (nonatomic, strong) UIButton *oneBtn;
@property (nonatomic, strong) UIButton *twoBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseView];

    [self loadWKWebView];
//    test
//    _urlString = @"http://m.baidu.com";
//    [self loadWKWebViewContentWithURLString:_urlString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationAction");
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        !decisionHandler?:decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        !decisionHandler?:decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
    
}

#pragma mark -- WKUIDelegate

//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//
//}

- (void)webViewDidClose:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
}

//- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo API_AVAILABLE(ios(10.0)) {
//    return YES;
//}

//- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0)){
//}

- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController API_AVAILABLE(ios(10.0)) {
    
}

#pragma mark -- WKScriptMessageHandler

//这个协议中包含一个必须实现的方法，这个方法是native与web端交互的关键，它可以直接将接收到的JS脚本转为OC或Swift对象。
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",message.body);
    
    if ([message.name isEqualToString:@"onNoneParamClicked"]) {
        NSLog(@"没有参数");
    }
    
    if ([message.name isEqualToString:@"onOneParamClicked"]) {
        NSLog(@"一个参数");
    }
    
    if ([message.name isEqualToString:@"onTwoParamsClicked"]) {
        NSLog(@"两个参数");
    }}

#pragma mark -- custom methods

- (void)loadWKWebView {
    
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    configuration.preferences.minimumFontSize = 18.f;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/2) configuration:configuration];
    [self.view addSubview:_webView];
//    _webView.UIDelegate = self;
//    _webView.navigationDelegate = self;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"webInteractive" ofType:@"html"];
    NSURL *baseUrl = [[NSBundle mainBundle] bundleURL];
    [_webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseUrl];
    
    WKUserContentController *userCC = configuration.userContentController;
    
//    js 调用oc的代码，添加用于处理脚本
//     这里的参数对应的是《// js响应html页面方法》 看是那个发出消息的，所以这里应该是相当于发出详细的标示
    [userCC addScriptMessageHandler:self name:@"onNoneParam"];
    [userCC addScriptMessageHandler:self name:@"onOneParam"];
    [userCC addScriptMessageHandler:self name:@"onTwoParams"];

}

- (void)loadBaseView {
    
    _noneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _noneBtn.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)/2, 100.f, 30.f);
    [self.view addSubview:_noneBtn];
    [_noneBtn setTitle:@"没有参数oc" forState:UIControlStateNormal];
    [_noneBtn addTarget:self action:@selector(onNoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _oneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _oneBtn.frame = CGRectMake(110, CGRectGetHeight([UIScreen mainScreen].bounds)/2, 100.f, 30.f);
    [self.view addSubview:_oneBtn];
    [_oneBtn setTitle:@"一个参数oc" forState:UIControlStateNormal];
    [_oneBtn addTarget:self action:@selector(onOneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _twoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _twoBtn.frame = CGRectMake(230, CGRectGetHeight([UIScreen mainScreen].bounds)/2, 100.f, 30.f);
    [self.view addSubview:_twoBtn];
    [_twoBtn setTitle:@"两个参数oc" forState:UIControlStateNormal];
    [_twoBtn addTarget:self action:@selector(onTwoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onNoneBtnClicked {
    [_webView evaluateJavaScript:@"onNoneParamClicked()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"onNoneParamClicked complete:%@",response);
    }];
}

- (void)onOneBtnClicked {
    [_webView evaluateJavaScript:@"onOneParamClicked('aka')" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"showOneParam complete,%@",response);
    }];
}

- (void)onTwoBtnClicked {
    [_webView evaluateJavaScript:@"onTwoParamsClicked('aka','man')" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"onTwoParamsClicked complete %@",response);
    }];
}

- (void)loadWKWebViewContentWithURLString:(NSString *)urlString {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_webView loadRequest:request];
}

@end
