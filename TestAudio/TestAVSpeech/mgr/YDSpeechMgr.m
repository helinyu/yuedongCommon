//
//  YDSpeechMgr.m
//  TestAVSpeech
//
//  Created by Aka on 2017/8/30.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDSpeechMgr.h"
#import <AVFoundation/AVFoundation.h>

@interface YDSpeechMgr ()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesisVoice *speechSynthesisVoice;
@property (nonatomic, strong) AVSpeechSynthesizer *speechSysthesizer;

@end

@implementation YDSpeechMgr

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBase];
    }
    return self;
}

- (void)initBase {
    _speechSysthesizer = [AVSpeechSynthesizer new];
    _speechSysthesizer.delegate = self;
}

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (NSArray *)speachLanguageVoice {
    NSArray *voices = [AVSpeechSynthesisVoice speechVoices];
    for (AVSpeechSynthesisVoice *voice  in voices) {
        NSLog(@"voice is : %@",voice);
    }
    return voices;
}

- (void)speachWithText:(NSString *)text {
//    BOOL isSpeeking = _speechSysthesizer.isSpeaking;
//    BOOL isPause = _speechSysthesizer.isPaused;
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    NSLog(@"voice identifier; %@ ,language :%@, name :%@ quality :%ld,current code :%@",voice.identifier,voice.language,voice.name,(long)voice.quality, [AVSpeechSynthesisVoice currentLanguageCode]);//com.apple.ttsbundle.Sin-Ji-compact
    utterance.voice = voice;
    utterance.rate = 0.f;
    utterance.pitchMultiplier = 0.8f;
    utterance.postUtteranceDelay = 0.1f;

    [_speechSysthesizer speakUtterance:utterance];
    
}

- (void)testConstants {
    NSLog(@"const min:%f",AVSpeechUtteranceMinimumSpeechRate);
    NSLog(@"const max:%f",AVSpeechUtteranceMaximumSpeechRate);
    NSLog(@"const defualt :%f",AVSpeechUtteranceDefaultSpeechRate);
}

#pragma mark -- speech synthesizer delegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"开始播放声音");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"语音播放结束");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"语音播放暂停");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"语音播放继续");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"放弃语音播放");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
    NSLog(@"正在播放的文字： %@",[utterance.speechString substringWithRange:characterRange]);
}

@end
