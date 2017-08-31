//
//  ViewController.m
//  TestAVSpeech
//
//  Created by Aka on 2017/8/30.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDSpeechMgr.h"
#import "YDObjectRetain.h"

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

@interface ViewController ()

@property (nonatomic, strong) UITextField *inputTextfield;

@property (nonatomic, retain) YDObjectRetain *objR;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCom];

}

- (void)initCom {
    _inputTextfield = [UITextField new];
    _inputTextfield.frame = CGRectMake(100, 100, 200, 40);
    _inputTextfield.textAlignment = NSTextAlignmentLeft;
    _inputTextfield.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_inputTextfield];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放语音" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSpeechText:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 200, 100, 40);
    
    UIButton *langueBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [langueBtn setTitle:@"获取语言列表" forState:UIControlStateNormal];
    [langueBtn addTarget:self action:@selector(printVoices) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:langueBtn];
    langueBtn.frame = CGRectMake(100, 250, 100, 40);

}

- (void)onSpeechText:(UIButton *)sender {
    [[YDSpeechMgr shared] speachWithText:_inputTextfield.text];
}

- (void)printVoices {
//    [[YDSpeechMgr shared] speachLanguageVoice];
    
    [self testRetain];
}

- (void)testRetain {
    _objR = [[YDObjectRetain alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
