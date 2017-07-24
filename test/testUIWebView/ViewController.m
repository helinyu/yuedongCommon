//
//  ViewController.m
//  testUIWebView
//
//  Created by Aka on 2017/7/24.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIButton *noneParamBtn;
@property (nonatomic, strong) UIButton *oneParamBtn;
@property (nonatomic, strong) UIButton *twoParamsBtn;

@end

static const CGFloat webViewH = 300.f;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadWebView];
    [self loadBaseComponent];
    
}

- (void)loadBaseComponent {
    _noneParamBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_noneParamBtn];
    _noneParamBtn.backgroundColor = [UIColor redColor];
    [_noneParamBtn setTitle:@"没有参数" forState:UIControlStateNormal];
    _noneParamBtn.frame = CGRectMake(0,webViewH + 20,100, 30);
    [_noneParamBtn addTarget:self action:@selector(onNoneParamClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _oneParamBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_oneParamBtn];
    [_oneParamBtn setTitle:@"一个参数" forState:UIControlStateNormal];
    _oneParamBtn.frame = CGRectMake(0, webViewH + 60, 100, 30);
    [_oneParamBtn addTarget:self action:@selector(onOneParamClicked) forControlEvents:UIControlEventTouchUpInside];
    _oneParamBtn.backgroundColor = [UIColor redColor];

    _twoParamsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_twoParamsBtn];
    [_twoParamsBtn setTitle:@"两个参数" forState:UIControlStateNormal];
    _twoParamsBtn.frame = CGRectMake(0,webViewH +100, 100, 30);
    [_twoParamsBtn addTarget:self action:@selector(onTwoParamClicked) forControlEvents:UIControlEventTouchUpInside];
    _twoParamsBtn.backgroundColor = [UIColor redColor];


}

- (void)onNoneParamClicked {
    NSLog(@"none param");
//    当html页面注入了之后，这个webView对象执行这个方法就是执行嵌入的html的 onNoneParamClicked 这个方法
    [self.webView stringByEvaluatingJavaScriptFromString:@"alertMobile()"];
}

- (void)onOneParamClicked {
    NSLog(@"one param");
    [self.webView stringByEvaluatingJavaScriptFromString:@"alertName('aka')"];

}

- (void)onTwoParamClicked {
    NSLog(@"two params");
    [self.webView stringByEvaluatingJavaScriptFromString:@"alertSendMsg('18870707070','周末爬山真是件愉快的事情')"];
}

- (void)loadWebView {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), webViewH)];
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor yellowColor];
    _webView.tintColor = [UIColor yellowColor];
    self.view.backgroundColor = [UIColor  grayColor];
    _webView.delegate = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseUrl = [[NSBundle mainBundle] bundleURL];
    [_webView loadHTMLString:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] baseURL:baseUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- uiwebview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"navigationType: %ld",navigationType);
  
    NSString *scheme = @"rrcc://";

    NSString *absolutePath = request.URL.absoluteString;
    if ([absolutePath hasPrefix:scheme]) {
        NSString *subPath = [absolutePath substringFromIndex:scheme.length];
        if ([subPath containsString:@"?"]) {//1个或多个参数
            
            if ([subPath containsString:@"&"]) {//多个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];
                
                NSString *methodName = [components firstObject];
                
                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);
                
                NSString *parameter = [components lastObject];
                NSArray *params = [parameter componentsSeparatedByString:@"&"];
                
                if (params.count == 2) {
                    if ([self respondsToSelector:sel]) {
                        [self performSelector:sel withObject:[params firstObject] withObject:[params lastObject]];
                    }
                }
                
                
            } else {//1个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];
                
                NSString *methodName = [components firstObject];
                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);
                
                NSString *parameter = [components lastObject];
                
                if ([self respondsToSelector:sel]) {
                    [self performSelector:sel withObject:parameter];
                }
                
            }
            
        } else {//没有参数
            NSString *methodName = [subPath stringByReplacingOccurrencesOfString:@"_" withString:@":"];
            SEL sel = NSSelectorFromString(methodName);
            
            if ([self respondsToSelector:sel]) {
                [self performSelector:sel];
            }
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

//js 调用oc的方法

- (void)showMobile {
    NSLog(@"js 调用oc没有参数的方法");
    [SVProgressHUD showSuccessWithStatus:@"没有参数"];
}

- (void)showName:(NSString *)name {
    NSLog(@"js 调用oc只有一个参数的方法");
    [SVProgressHUD showSuccessWithStatus:@"一个参数"];
}

- (void)showSendNumber:(NSString *)name msg:(NSInteger)man {
    NSLog(@"js 调用oc 有两个方法");
    [SVProgressHUD showSuccessWithStatus:@"两个参数"];
}

@end
