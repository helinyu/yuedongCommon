//
//  YDAudioSessionMgr.h
//  SportsBar
//
//  Created by Aka on 2017/8/28.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INCREASE_AUDIOSESSION_ONE [[YDAudioSessionMgr shared] increaseOne]
#define REDUCE_AUDIOSESSION_ONE [[YDAudioSessionMgr shared] reduceOne]
#define SET_PLAYBACK_MIXWITHOTHERS [[YDAudioSessionMgr shared] setAudioPlayBackAndMixEnv]
#define SET_PLAYBACK [[YDAudioSessionMgr shared] setPlayBack]
#define SET_PLAYBACK_MIXOPTION_IF_NOT_M7 [[YDAudioSessionMgr shared] setPlayBackWithMixOptionIfNotM7]

@interface YDAudioSessionMgr : NSObject

+ (instancetype)shared;
@property (nonatomic, assign, readonly) NSInteger liveNum;

#pragma mark -- livenum
- (BOOL)reduceOne;
- (BOOL)increaseOne;

- (void)forceRescoveryActive;
- (void)forceStopActive;

// 切换扬声器、听筒、保留其他应用
+ (BOOL)enableCategoryAudioProcessing;
+ (BOOL)enableCategoryPlayAndRecord;
+ (BOOL)enableCategoryRecord;
+ (BOOL)enableCategorySoloAmbient;
+ (BOOL)enableCategoryPlayback;
+ (BOOL)enableCategoryAmbient;
+ (BOOL)enableCategoryMixWithOthers;

- (void)setAudioPlayBackAndMixEnv;
- (void)setPlayBack;
- (void)setPlayBackWithMixOptionIfNotM7;

- (void)updateAudioSessionState;

@end

