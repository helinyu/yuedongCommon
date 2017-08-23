//
//  YDScreenStateMgr.m
//  TestAudio
//
//  Created by Aka on 2017/8/23.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDScreenStateMgr.h"

#define NotificationLock CFSTR("com.apple.springboard.lockcomplete")
#define NotificationLockState CFSTR("com.apple.springboard.lockstate")
#define NotificationBlankedScreen CFSTR("com.apple.springboard.hasBlankedScreen")

@implementation YDScreenStateMgr

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
        [self loadBase];
    }
    return self;
}

- (void)loadBase{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationLock, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationLockState, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationBlankedScreen, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

static void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo)
{
    NSString* lockstate = (__bridge NSString*)name;
    if ([lockstate isEqualToString:(__bridge  NSString*)NotificationLock]) {
        NSLog(@"locked.");
    }
    else if([lockstate isEqualToString:(__bridge NSString *)NotificationLockState]){
        NSLog(@"lock state locake state.");
    }
    else if([lockstate isEqualToString:(__bridge NSString *)NotificationBlankedScreen]) {
        NSLog(@"blank screen");
    }
    
}



@end
