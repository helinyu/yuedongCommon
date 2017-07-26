//
//  YDJavascriptBridge.m
//  YDJavascriptBridge
//
//  Created by Aka on 2017/7/26.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDJavascriptBridge.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface YDJavascriptBridge ()

@property (nonatomic, strong) UIWebView *lWebView;
@property (nonatomic, strong) WKWebView *hwebView;
@property (nonatomic, strong) id webView;

//mark uiwebview
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation YDJavascriptBridge

+ (instancetype)bridgeWithUIWebview:(UIWebView *)webView {
    return [YDJavascriptBridge _bridgewithWebView:webView];
}

+ (instancetype)bridgeWithWKWebView:(WKWebView *)webView {
    return [YDJavascriptBridge _bridgewithWebView:webView];
}

+ (instancetype)_bridgewithWebView:(id)webView {
    YDJavascriptBridge *bridge = [YDJavascriptBridge new];
    if ([webView isKindOfClass:[UIWebView class]]) {
        bridge.lWebView = webView;
        [bridge baseConfigureUIWebView];
    }else{
        bridge.hwebView = webView;
    }
    bridge.webView = webView;
    return bridge;
}

- (void)baseConfigureUIWebView {
    _jsContext = [_lWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _jsContext[@"showNOParam"] = ^(void) {
        NSLog(@"on show");
    };
}

- (void)evaluateScript:(NSString *)script {
    if (_lWebView) {
        [_jsContext evaluateScript:script];
    }else{
//        wk webview
    }
}

@end
