//
//  YDSpeechMgr.h
//  TestAVSpeech
//
//  Created by Aka on 2017/8/30.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDSpeechMgr : NSObject;

+ (instancetype)shared;

- (NSArray *)speachLanguageVoice;

- (void)speachWithText:(NSString *)text;

@end
