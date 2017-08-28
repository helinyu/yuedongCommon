//
//  YDAudioMgr.m
//  TestAudio
//
//  Created by Aka on 2017/8/24.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDAudioNodeMgr.h"
#import <AVFoundation/AVFoundation.h>

@interface YDAudioNodeMgr ()

@property (nonatomic, strong) AVAudioEngine *audioEngine;

@property (nonatomic, strong) AVAudioPlayerNode *playerNode;

@property (nonatomic, strong) AVAudioUnit *audioUnit;

@property (nonatomic, strong) AVAudioUnitReverb *audioUnitReverb;

@property (nonatomic, strong) AVAudioUnitEQ *audioUnitEQ;
@property (nonatomic, strong) AVAudioUnitDistortion *audioUnitDistotion;
@property (nonatomic, strong) AVAudioUnitDelay *audioUnitDelay;

@end

@implementation YDAudioNodeMgr


+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _audioEngine = [AVAudioEngine new];
    }
    return self;
}


- (void)play {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"父亲.mp3" ofType:nil];
    _playerNode = [AVAudioPlayerNode new];

    
}


@end
