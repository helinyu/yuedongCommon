//
//  ViewController.m
//  CallKit
//
//  Created by Aka on 2017/8/19.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <CallKit/CallKit.h>

@interface ViewController ()

@property (nonatomic, strong) UITextField *noTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"callkit host app" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onCallKitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);

    self.noTextField = [UITextField new];
    self.noTextField.frame = CGRectMake(100, 150, 100, 30);
    [self.view addSubview:self.noTextField];
    
}

- (void)onCallKitClick {
    NSLog(@"on call kit click");
}

- (void) onTelClick {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.noTextField.text];
//    call view 应该是怎么样进行处理？
//    [self.callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    if (!self.callWebview.subviews) {
//        [self.view addSubview:_callWebview];
//    }
}

- (void) onCallDirectoryClick {
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    // 获取权限状态
    [manager getEnabledStatusForExtensionWithIdentifier:@"com.tq.cccccccccalldemo.CallDirectoryExtension" completionHandler:^(CXCallDirectoryEnabledStatus enabledStatus, NSError * _Nullable error) {
        if (!error) {
            NSString *title = nil;
            if (enabledStatus == CXCallDirectoryEnabledStatusDisabled) {
                /*
                 CXCallDirectoryEnabledStatusUnknown = 0,
                 CXCallDirectoryEnabledStatusDisabled = 1,
                 CXCallDirectoryEnabledStatusEnabled = 2,
                 */
                title = @"未授权，请在设置->电话授权相关权限";
            }else if (enabledStatus == CXCallDirectoryEnabledStatusEnabled) {
                title = @"授权";
            }else if (enabledStatus == CXCallDirectoryEnabledStatusUnknown) {
                title = @"不知道";
            }
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:title
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"有错误"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
