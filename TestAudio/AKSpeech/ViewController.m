//
//  ViewController.m
//  AKSpeech
//
//  Created by Aka on 2017/8/30.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "AKSpeechMgr.h"
#import "AKSpeechModel.h"

@interface ViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放语音" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlayUtterance) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 40);
    
    UITextView *textview = [UITextView new];
    textview.frame = CGRectMake(100, 200, 200, 200);
    textview.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textview];
    _textView = textview;

}

- (void)onPlayUtterance {
    NSString *text  = _textView.text;
    AKSpeechModel *item = [AKSpeechModel new];
    item.contentText = text;
    item.language = @"zh-CN";
    item.rate = 0.5;
    item.pitchMultiPlier = 0.8;
//    item.volume = 1;
    item.preUtteranceDelay = 0.1f;
    item.postUtteranceDelay = 0.1f;
    [[AKSpeechMgr shared] speechWithItem:item complete:^(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterance, NSRange characterRange, AKASpeechDelegateType type) {
        NSLog(@"type: %ld , character :%@",(long)type,[utterance.speechString substringWithRange:characterRange]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
