//
//  YDBluetoothWebView.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDBluetoothWebView.h"
#import <WebKit/WebKit.h>
#import "YDSystem.h"

@interface YDBluetoothWebView () <UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>

//mark -- UI
@property (nonatomic, strong) UIWebView *lwebView;
@property (nonatomic, strong) WKWebView *hWebView; // high version webview which use in ios 8 and greater
@property (nonatomic, strong) id webView;

@end

@implementation YDBluetoothWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
    }
    return self;
}

- (void)comInit {
    if ([YDSystem isGreaterOrEqualThen8]) {
        _hWebView = [[WKWebView alloc] initWithFrame:self.bounds];
        _webView = _hWebView;
        _hWebView.backgroundColor = [UIColor redColor];
        _hWebView.navigationDelegate = self;
        _hWebView.UIDelegate = self;
        [self addSubview:_hWebView];
    }else{
        _lwebView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView = _lwebView;
        _lwebView.delegate = self;
        _lwebView.scalesPageToFit = YES;
        _lwebView.dataDetectorTypes = UIDataDetectorTypeAll;
        _lwebView.allowsLinkPreview = YES;
        _lwebView.allowsInlineMediaPlayback = NO;
        _lwebView.mediaPlaybackRequiresUserAction = YES;
        _lwebView.mediaPlaybackAllowsAirPlay = YES;
        _lwebView.suppressesIncrementalRendering = NO;
        _lwebView.keyboardDisplayRequiresUserAction =YES;
//        _lwebView.paginationMode = UIWebPaginationModeUnpaginated;
//        _lwebView.paginationBreakingMode = UIWebPaginationBreakingModePage;
//        _lwebView.pageLength = 1.f;
//        _webView.gapBetweenPages = 1.f;
//        _webView.pagecount readonly
//        _lwebView.allowsPictureInPictureMediaPlayback = YES;
        [self addSubview:_lwebView];
    }
}

- (YDBluetoothWebView *(^)(NSURL *url))requestWithUrl {
    __weak typeof (self) wSelf = self;
    return ^(NSURL *url) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf.webView performSelectorOnMainThread:@selector(loadRequest:) withObject:[NSURLRequest requestWithURL:url] waitUntilDone:YES];
//                [wSelf.webView loadRequest:[NSURLRequest requestWithURL:url]];
        });
        return self;
    };
}

#pragma mark -- UIWebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    用于解析返回来的参数
    NSLog(@"shouldStartLoadWithRequest");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
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
//
//}

//- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0)) {
//
//}

- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController API_AVAILABLE(ios(10.0)) {
    
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
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



@end
