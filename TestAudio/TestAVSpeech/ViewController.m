//
//  ViewController.m
//  TestAVSpeech
//
//  Created by Aka on 2017/8/30.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDSpeechMgr.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *inputTextfield;

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
//    - (NSArray *)speachLanguageVoice {
    [[YDSpeechMgr shared] speachLanguageVoice];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
