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

@property (nonatomic, strong) YDBluetoothWebViewMgr *webViewMgr;

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
    
    [_webViewMgr configureWithWebView:_superWebView];
    [_webViewMgr registerHandler];

    _superWebView.requestWithUrl(_webViewMgr.urlString);
    
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

- (YDBlueToothWebViewController *(^)(YDBluetoothWebViewMgr *mgr))deliverWebViewMgr {
    __weak typeof (self) wSelf = self;
    return ^(YDBluetoothWebViewMgr *mgr) {
        if (mgr) {
            wSelf.webViewMgr = mgr;
        }
        return self;
    };
}


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
