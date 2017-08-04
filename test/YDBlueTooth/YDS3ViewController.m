//
//  YDS3ViewController.m
//  test
//
//  Created by Aka on 2017/7/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDS3ViewController.h"

@interface YDS3ViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation YDS3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
