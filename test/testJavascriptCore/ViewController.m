//
//  ViewController.m
//  testUIWebView
//
//  Created by Aka on 2017/7/24.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MyCustomCoreViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIButton *noneParamBtn;
@property (nonatomic, strong) UIButton *oneParamBtn;
@property (nonatomic, strong) UIButton *twoParamsBtn;

@property (nonatomic, strong) UIButton *customBtn;

@property (nonatomic, strong) JSContext *jsContext;

@end

static const CGFloat webViewH = 250.f;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadWebView];
    [self callBackMethods];
    [self loadBaseComponent];
    
}

- (void)callBackMethods {
    //初始化JSContext
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常捕获信息：%@", exceptionValue);
    };
    
    __block typeof(self) wSelf = self;
    //JS调用OC方法列表
    
    self.jsContext[@"showMobile"] = ^ {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf showMsg:@"我是下面的小红 手机号是:18870707070"];
        });
    };
    
    self.jsContext[@"showName"] = ^ (NSString *name) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *info = [NSString stringWithFormat:@"你好 %@, 很高兴见到你",name];
            [wSelf showMsg:info];
        });
    };
    
    void (^_showSendMsg) (NSString *num, NSString *msg) = ^ (NSString *num, NSString *msg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *info = [NSString stringWithFormat:@"这是我的手机号: %@, %@ !!",num,msg];
            [wSelf showMsg:info];
        });
    };
    
    self.jsContext[@"showSend3Msg"] = ^(NSString *name, NSString *sex, NSString *age) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *info = [NSString stringWithFormat:@"name:%@, sex: %@ ,age: %@",name,sex,age];
            [wSelf showMsg:info];
        });
    };
    
    [self.jsContext setObject:_showSendMsg forKeyedSubscript:@"showSendMsg"];
}

- (void)showMsg:(NSString *)msg {
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (void)loadBaseComponent {
    _noneParamBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_noneParamBtn];
    _noneParamBtn.backgroundColor = [UIColor redColor];
    [_noneParamBtn setTitle:@"没有参数" forState:UIControlStateNormal];
    _noneParamBtn.frame = CGRectMake(0,webViewH + 20, 100, 30);
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
    
    _customBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_customBtn];
    _customBtn.frame = CGRectMake(0,webViewH +140, 100, 30);
    [_customBtn addTarget:self action:@selector(onToCustomClicked) forControlEvents:UIControlEventTouchUpInside];
    [_customBtn setTitle:@"to custom" forState:UIControlStateNormal];
    
}

- (void)onToCustomClicked {
    MyCustomCoreViewController *vc = [MyCustomCoreViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onNoneParamClicked {
    [self.jsContext evaluateScript:@"alertMobile()"];
}

- (void)onOneParamClicked {
    [self.jsContext evaluateScript:@"alertName('aka')"];
}

- (void)onTwoParamClicked {
    [self.jsContext evaluateScript:@"alertSendMsg('aka','man')"];
}

- (void)loadWebView {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), webViewH)];
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor yellowColor];
    _webView.tintColor = [UIColor yellowColor];
    self.view.backgroundColor = [UIColor  grayColor];
    _webView.delegate = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"webInteractive.html" ofType:nil];
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
    
    NSString *absolutePath = request.URL.absoluteString;
    NSString *scheme = @"ydq://";
    
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
- (void)showNoneParam {
    [SVProgressHUD showWithStatus:@"没有参数"];
}

- (void)showOneParam:(NSString *)name {
    [SVProgressHUD showWithStatus:@"一个参数"];
}

- (void)showTwoParams:(NSString *)name sex:(NSString *)sex {
    [SVProgressHUD showWithStatus:@"两个参数"];
    
}

@end

