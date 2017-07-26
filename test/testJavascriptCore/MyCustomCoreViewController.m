//
//  MyCustomCoreViewController.m
//  testJavascriptCore
//
//  Created by Aka on 2017/7/26.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "MyCustomCoreViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface MyCustomCoreViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic, strong) UIButton *customBtn;

@end

@implementation MyCustomCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];

    _customBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_customBtn];
    _customBtn.frame = CGRectMake(0, 400, 100, 30);
    [_customBtn setTitle:@"oc 调用js" forState:UIControlStateNormal];
    [_customBtn addTarget:self action:@selector(onTestClicked) forControlEvents:UIControlEventTouchUpInside];

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/2.f)];
    [self.view addSubview:_webView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"custom" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
    _jsContext = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];


    __block typeof(self) weakSelf = self;
    //JS调用OC方法列表
    _jsContext[@"showNOParam"] = ^ {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showMsg:@"js 调用oc代码"];
        });
    };
}

- (void)onTestClicked {
    [_jsContext evaluateScript:@"onshow()"];
}

- (void)showMsg:(NSString *)msg {
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
