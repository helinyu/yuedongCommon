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

@interface YDBlueToothWebViewController ()

//mark -- nomal attribute
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, strong) YDBluetoothWebView *webView;

@end

@implementation YDBlueToothWebViewController

#pragma mark -- system function

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    
//    self.title = _titleString;
    
    [self webViewInit];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.webView.requestWithUrl(_url);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- custom methods
- (void)webViewInit {
    _webView = [[YDBluetoothWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
}

#pragma mark - convert the attribute for vc by block
- (YDBlueToothWebViewController *(^)(NSString *urlString))webUrl {
    __weak typeof (self) wSelf = self;
    return ^(NSString *urlString){
        if (urlString.length > 0) {
            NSString *linkUrlString = urlString; 
            // configure the whole by the host url
            wSelf.url = [NSURL URLWithString:linkUrlString];
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
