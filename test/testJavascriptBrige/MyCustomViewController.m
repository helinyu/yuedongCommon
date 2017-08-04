//
//  MyCustomViewController.m
//  testJavascriptBrige
//
//  Created by Aka on 2017/7/25.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "MyCustomViewController.h"
#import "WebViewJavascriptBridge.h"

@interface MyCustomViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@property (nonatomic, strong) UIButton *noneBtn;
@property (nonatomic, strong) UIButton *oneBtn;
@property (nonatomic, strong) UIButton *twoBtn;

@end

@implementation MyCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseView];
    [self loadConfigration];

}

- (void)loadConfigration {

    [WebViewJavascriptBridge enableLogging];

    _bridge = [WebViewJavascriptBridge bridge:_webView];
    [_bridge setWebViewDelegate:self];

    [_bridge registerHandler:@"onNoneParam" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"bridge 没有参数");
        
    }];

    [_bridge registerHandler:@"onOneParam" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"datas : %@",data);
    }];

    [_bridge registerHandler:@"onTwoParams" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"on two params : %@",data);
    }];

}

- (void)loadBaseView {
    
    _noneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _noneBtn.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)/2 +50, 100.f, 30.f);
    [self.view addSubview:_noneBtn];
    [_noneBtn setTitle:@"没有参数oc" forState:UIControlStateNormal];
    [_noneBtn addTarget:self action:@selector(onNoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    _noneBtn.backgroundColor = [UIColor redColor];
    
    _oneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _oneBtn.frame = CGRectMake(110, CGRectGetHeight([UIScreen mainScreen].bounds)/2 +50, 100.f, 30.f);
    [self.view addSubview:_oneBtn];
    [_oneBtn setTitle:@"一个参数oc" forState:UIControlStateNormal];
    [_oneBtn addTarget:self action:@selector(onOneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    _oneBtn.backgroundColor = [UIColor redColor];
    
    _twoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _twoBtn.frame = CGRectMake(230, CGRectGetHeight([UIScreen mainScreen].bounds)/2 +50, 100.f, 30.f);
    [self.view addSubview:_twoBtn];
    [_twoBtn setTitle:@"两个参数oc" forState:UIControlStateNormal];
    [_twoBtn addTarget:self action:@selector(onTwoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    _twoBtn.backgroundColor = [UIColor redColor];
    
    //加载webView
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)/2)];
    [self.view addSubview:_webView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"webInteractive" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [_webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
}

- (void)onNoneBtnClicked {
    [_bridge callHandler:@"noneParam"];
}

- (void)onOneBtnClicked {
    [_bridge callHandler:@"oneParam" data:@"aka"];
}

- (void)onTwoBtnClicked {
    [_bridge callHandler:@"twoParams" data:@{@"name":@"aka_oc",@"sex":@"man"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
