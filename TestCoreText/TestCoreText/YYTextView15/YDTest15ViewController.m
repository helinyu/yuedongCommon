//
//  YDTest15ViewController.m
//  TestCoreText
//
//  Created by mac on 5/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest15ViewController.h"
#import <YYTextView.h>
#import <YYKeyboardManager.h>
#import "Masonry.h"

@interface YDTest15ViewController ()<YYKeyboardObserver>

@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) UIButton *tapBtn;

@end

@implementation YDTest15ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   [self.view addSubview:_tapBtn];
    _tapBtn.backgroundColor = [UIColor redColor];
    [_tapBtn addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
    [_tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(64);
        make.width.height.mas_equalTo(100);
    }];
    
    YYTextView *textView= [YYTextView new];
    textView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textView];
    _textView  = textView;
    _textView.frame = CGRectMake(0, self.view.bounds.size.height -100, self.view.bounds.size.width, 100);
    
    UIWindow *widow = [YYKeyboardManager defaultManager].keyboardWindow;
    UIView *keyboardView = [YYKeyboardManager defaultManager].keyboardView;
    BOOL flag = [YYKeyboardManager defaultManager].keyboardVisible;
    CGRect rect = [YYKeyboardManager defaultManager].keyboardFrame;
    [[YYKeyboardManager defaultManager] addObserver:self];
    NSLog(@"sdf");
}

- (void)onTap:(id)sender {
    [_textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)keyboardChangedWithTransition:(YYKeyboardTransition)transition {
    UIWindow *widow = [YYKeyboardManager defaultManager].keyboardWindow;
    UIView *keyboardView = [YYKeyboardManager defaultManager].keyboardView;
    BOOL flag = [YYKeyboardManager defaultManager].keyboardVisible;
    CGRect rect = [YYKeyboardManager defaultManager].keyboardFrame;

    BOOL fromFlag = transition.fromVisible;
    BOOL toFlag = transition.toVisible;
    CGRect fromFrame = transition.fromFrame;
    CGRect toFrame = transition.toFrame;
    NSTimeInterval duration = transition.animationDuration;
    UIViewAnimationCurve curve = transition.animationCurve;
    UIViewAnimationOptions *options = transition.animationOption;
    if (toFlag) {
        _textView.frame = CGRectMake(0, self.view.bounds.size.height -100 -toFrame.size.height, self.view.bounds.size.width, 100);
//        [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view).offset(-toFrame.size.height);
//        }];
    }else {
        _textView.frame = CGRectMake(0, self.view.bounds.size.height -100, self.view.bounds.size.width, 100);
//        [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view);
//        }];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
