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

@property (nonatomic, strong) YDBluetoothWebView *webView;

@end

@implementation YDBlueToothWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self webViewInit];
}

- (void)webViewInit {
    _webView = [[YDBluetoothWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.webView.requestWithUrl(_url);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- custom methods
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

@end
