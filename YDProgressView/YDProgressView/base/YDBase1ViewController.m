//
//  YDBase1ViewController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDBase1ViewController.h"

@interface YDBase1ViewController ()

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation YDBase1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"frame 初始化" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onFrameMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 100, 100, 30);

    UIButton *styleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [styleBtn setTitle:@"style 初始化" forState:UIControlStateNormal];
    [styleBtn addTarget:self action:@selector(onStyleMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:styleBtn];
    styleBtn.frame = CGRectMake(110, 100, 100, 30);

    
//    @property(nonatomic, strong, nullable) UIImage* progressImage      NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//    @property(nonatomic, strong, nullable) UIImage* trackImage         NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//    //
//    @property(nonatomic, strong, nullable) NSProgress *observedProgress NS_AVAILABLE_IOS(9_0);
//    
//    @end
    
}

- (void)onFrameMethod {
    [self test0];
}

- (void)onStyleMethod {
    [self test1];
}

- (void)test0 {
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 200, 300, 2)];
    [self.view addSubview:progressView];
    progressView.progressViewStyle = UIProgressViewStyleDefault;
    [progressView setProgress:0.4 animated:YES];
    progressView.progressImage = [UIImage imageNamed:@"Snip20170901_1.png"];
    progressView.trackImage = [UIImage imageNamed:@"Snip20170901_5.png"];
}


//样式初始化
- (void)test1 {
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    [self.view addSubview:progressView];
//    progressView.trackTintColor = [UIColor purpleColor];
//    progressView.progressTintColor = [UIColor greenColor];
    progressView.tintColor = [UIColor darkGrayColor];
    progressView.backgroundColor = [UIColor yellowColor];
//    其实这两个属性和上面两个是一样的
    progressView.progress = 0.5;
    progressView.frame = CGRectMake(0, 210, 300, 2);
    
    
}

- (void)testAttribute {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
