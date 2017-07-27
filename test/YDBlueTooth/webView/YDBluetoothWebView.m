//
//  YDBluetoothwebView.m
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
@property (nonatomic, strong) WKWebView *hwebView; // high version webview which use in ios 8 and greater
@property (nonatomic, strong, readwrite) id webView;

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
        _hwebView = [[WKWebView alloc] initWithFrame:self.bounds];
        _hwebView = _hwebView;
        _hwebView.backgroundColor = [UIColor redColor];
        _hwebView.navigationDelegate = self;
        _hwebView.UIDelegate = self;
        [self addSubview:_hwebView];
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

- (YDBluetoothWebView *(^)(NSString *urlString))requestWithUrl {
    __weak typeof (self) wSelf = self;
    return ^(NSString *urlString) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *filePath = [[NSBundle mainBundle] pathForResource:urlString ofType:nil];
            NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
            if ([YDSystem isGreaterOrEqualThen8]) {
                [wSelf.hwebView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
            }else{
                [wSelf.lwebView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
            }
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


@end
