//
//  HLYAudioPlayer.m
//  AudioResolution
//
//  Created by felix on 2017/6/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYAudioPlayerManager.h"
#import <AVFoundation/AVFAudio.h>

@interface HLYAudioPlayerManager ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, copy) NSString *currentUrlString;
@property (nonatomic, strong) NSURL *currenUrl;

@end

static HLYAudioPlayerManager *singleTon = nil;

@implementation HLYAudioPlayerManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = [HLYAudioPlayerManager new];
    });
    return singleTon;
}

- (void)playerAudioWithUrl:(NSString *)urlString {
    _currenUrl = [NSURL URLWithString:urlString];
    NSError * audioPlayerError = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_currenUrl error:&audioPlayerError];
    [_audioPlayer play];
}

@end
