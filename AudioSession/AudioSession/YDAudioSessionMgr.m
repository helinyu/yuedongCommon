//
//  YDAudioSessionMgr.m
//  SportsBar
//
//  Created by Aka on 2017/8/28.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import "YDAudioSessionMgr.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioSession.h>


typedef NS_ENUM(NSInteger, YDAudioSessionActiveType) {
    YDAudioSessionActiveTypeDead = 0,
    YDAudioSessionActiveTypeAlive = 1,
};

@interface YDAudioSessionMgr ()

#pragma mark -- LiveAudioNum category

@property (nonatomic, assign) NSInteger liveNum;

@property (nonatomic, assign) BOOL hasSetting;

@end

@implementation YDAudioSessionMgr

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
        [self initBase];
    }
    return self;
}

- (void)initBase {
    [self _registerNotiOberser];
}

- (void)_registerNotiOberser {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAudioPlayerInterruptedNotify:) name:AVAudioSessionInterruptionNotification object:nil];
}


// notificaiton action methods
- (void)onAudioPlayerInterruptedNotify:(NSNotification *)noti {
    NSLog(@"音频打断");
////    [[NSNotificationCenter defaultCenter] postNotificationName:ydNtfAudioSessionInterruption object:nil];
//    if (![noti.userInfo.allKeys containsObject:AVAudioSessionInterruptionTypeKey]) {
//        return;
//    }
//    NSInteger interruptFlag =[[noti.userInfo objectForKey:AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
//    if (interruptFlag == AVAudioSessionInterruptionTypeBegan) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:ydNtfAudioSessionBeginInterruption object:nil];
////        [self forceStopActive];
//    }
//    else if (interruptFlag == AVAudioSessionInterruptionTypeEnded){
//        [self forceRescoveryActive];
//        [[NSNotificationCenter defaultCenter] postNotificationName:ydNtfAudioSessionEndInterruption object:nil];
//        if (![noti.userInfo.allKeys containsObject:AVAudioSessionInterruptionOptionKey]) {
//            return;
//        }
//        AVAudioSessionInterruptionOptions interruptionOptions = (AVAudioSessionInterruptionOptions)[[noti.userInfo objectForKey:AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
//        if (AVAudioSessionInterruptionOptionShouldResume == interruptionOptions) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:ydNtfAudioSessionEndInterruptionShouldResume object:nil];
//        }else{
//            [[NSNotificationCenter defaultCenter] postNotificationName:ydNtfAudioSessionEndInterruptionOther object:nil];
//        }
//    }
//    else{}
}

- (BOOL)reduceOne {
    
    if (self.liveNum <= YDAudioSessionActiveTypeDead) {
        return NO;
    }

    self.liveNum--;
    NSLog(@"live num :%ld",(long)self.liveNum);
    if (self.liveNum == YDAudioSessionActiveTypeDead) {
        NSLog(@"结束语音");
        AudioSessionSetActiveWithFlags(NO, kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation);
        NSError *error = nil;
        [[AVAudioSession sharedInstance] setActive:NO error:&error];
        if (error) {
            NSLog(@"errro :%@",error);
        }
//        [self _updateAudioSessionState:self.liveNum];
    }
    return YES;
}

- (BOOL)increaseOne {
    self.liveNum++;
    NSLog(@"live num ；%ld",(long)self.liveNum);
    if (self.liveNum >= YDAudioSessionActiveTypeAlive) {
        [self _updateAudioSessionState:self.liveNum];
    }
    return YES;
}

- (void)_updateAudioSessionState:(NSInteger)liveNum {
    if (liveNum == YDAudioSessionActiveTypeDead) {
        [YDAudioSessionMgr _unableActive];
    }
    else {
        [YDAudioSessionMgr _enableActive];
    }
}

- (void)updateAudioSessionState {
    [self _updateAudioSessionState:self.liveNum];
}

- (void)forceStopActive {
//    [[NSNotificationCenter defaultCenter] postNotificationName:ydNtfInactiveAudioSession object:nil];
    [YDAudioSessionMgr _unableActive];
}

- (void)forceRescoveryActive {
//    [[NSNotificationCenter defaultCenter] postNotificationName:ydNtfActiveAudioSession object:nil];
    [YDAudioSessionMgr _enableActive];
}

#pragma mark -- class methods

+ (BOOL)_commonActiceRegisterNotify:(BOOL)active {
//    NSError *error = nil;
//        BOOL result = [[AVAudioSession sharedInstance] setActive:active withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
//    if (error) {
//        MSLogD(@"error set active of audio session : %@",error);
//    }
//    return result;
    
    AudioSessionSetActiveWithFlags(active, kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation);
    NSError *error = nil;
    BOOL result = [[AVAudioSession sharedInstance] setActive:active error:&error];
    if (error) {
        NSLog(@"error set active of audio session : %@",error);
    }
    return result;

}

+ (BOOL)_unableActive {
//    [[NSNotificationCenter defaultCenter] postNotificationName:ydNtfInactiveAudioSession object:nil];
    return [YDAudioSessionMgr _commonActiceRegisterNotify:NO];
}

+ (BOOL)_enableActive {
    return [YDAudioSessionMgr _commonActiceRegisterNotify:YES];
}

#pragma mark -- kAudioSessionProperty_AudioCategory (应用内，应用环境)

+ (BOOL)enableCategoryAudioProcessing {
    return [YDAudioSessionMgr _enableSessionCategoryWithValue:AVAudioSessionCategoryAudioProcessing];
}

+ (BOOL)enableCategoryPlayAndRecord {
    return [YDAudioSessionMgr _enableSessionCategoryWithValue:AVAudioSessionCategoryPlayAndRecord];
}

+ (BOOL)enableCategoryRecord {
    return [YDAudioSessionMgr _enableSessionCategoryWithValue:AVAudioSessionCategoryRecord];
}

+ (BOOL)enableCategorySoloAmbient {
    return [YDAudioSessionMgr _enableSessionCategoryWithValue:AVAudioSessionCategorySoloAmbient];
}

+ (BOOL)enableCategoryAmbient {
    return [YDAudioSessionMgr _enableSessionCategoryWithValue:AVAudioSessionCategoryAmbient];
}

+ (BOOL)enableCategoryPlayback {
   return [YDAudioSessionMgr _enableSessionCategoryWithValue:AVAudioSessionCategoryPlayback];
}

+ (BOOL)_enableSessionCategoryWithValue:(NSString *const)categoryValue {
    NSError *error;
    BOOL result = [[AVAudioSession sharedInstance] setCategory:categoryValue error:&error];
    if (error) {
        NSLog(@"set catergory error : %@",error);
    }
    return result;
}

- (BOOL)_enableSessionCategoryWithValue:(NSString *const)categoryValue option:(AVAudioSessionCategoryOptions)option {
    NSError *error;
    BOOL result = [[AVAudioSession sharedInstance] setCategory:categoryValue withOptions:option error:&error];
    if (error) {
        NSLog(@"set category with option errro :%@",error);
    }
    return result;
}

#pragma mark -- AudioSession Properties (ID) act as option  （应用间 ，手机环境）

+ (BOOL)enableCategoryMixWithOthers {
    UInt32 flag = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(flag), &flag);
    if (result) {
        return NO;
        NSLog(@"result : %d --  flag : %d",(int)result,(unsigned int)flag);
    }
    return YES;
}

- (void)setAudioPlayBackAndMixEnv {
    if (_hasSetting) {
        return;
    }
//    NSError *error;
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error];
//    if (error) {
//        NSLog(@"set error");
//    }
    
//    这个设置有前后关系
    [YDAudioSessionMgr enableCategoryPlayback];
//    [YDAudioSessionMgr enableCategoryMixWithOthers];

    _hasSetting = YES;
}

-(void)setPlayBack {
    if (_hasSetting) {
        return;
    }
    [YDAudioSessionMgr enableCategoryPlayback];
    _hasSetting = YES;
}

- (void)setPlayBackWithMixOptionIfNotM7 {
        [self setPlayBack];
    
}

@end
