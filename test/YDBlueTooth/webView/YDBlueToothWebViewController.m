//
//  YDBlueToothWebViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDBlueToothWebViewController.h"
#import "YDBluetoothWebView.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "WebViewJavascriptBridge.h"
#import "YDSystem.h"
#import "YDBluetoothWebViewMgr.h"

@interface YDBlueToothWebViewController ()

//mark -- nomal attribute
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, strong) YDBluetoothWebView *superWebView;

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation YDBlueToothWebViewController

#pragma mark -- system function

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;

    _superWebView = [[YDBluetoothWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_superWebView];
    
    if ([YDSystem isGreaterOrEqualThen8]) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:_superWebView.hwebView];
    }else{
        _bridge = [WebViewJavascriptBridge bridgeForWebView:_superWebView.lwebView];
    }
    
    [_bridge registerHandler:@"register matheth" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"register handler datas");
    }];
    
//    注册的方法要在加载web之前
    _superWebView.requestWithUrl(_webViewMgr.urlString);
    _webViewMgr.bridge = _bridge;
    [_webViewMgr loadSerachBlueDatas];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- custom methods

#pragma mark - convert the attribute for vc by block


- (YDBlueToothWebViewController *(^)(NSString *titleString))webTittle {
    __weak typeof (self) wSelf = self;
    return ^(NSString *titleString) {
        if (titleString.length >0) {
            wSelf.titleString = titleString;
        }
        return self;
    };
}

@end
