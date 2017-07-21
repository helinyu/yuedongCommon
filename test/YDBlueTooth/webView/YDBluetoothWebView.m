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

@interface YDBluetoothWebView () <UIWebViewDelegate,WKNavigationDelegate>

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
        [self addSubview:_hWebView];
    }else{
        _lwebView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView = _lwebView;
        [self addSubview:_lwebView];
    }
}

- (YDBluetoothWebView *(^)(NSURL *url))requestWithUrl {
    __weak typeof (self) wSelf = self;
    return ^(NSURL *url) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([YDSystem isGreaterOrEqualThen8]) {
                [wSelf.hWebView loadRequest:[NSURLRequest requestWithURL:url]];
            }else{
                [wSelf.lwebView loadRequest:[NSURLRequest requestWithURL:url]];
            }
        });
        return self;
    };
}

@end
