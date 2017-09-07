//
//  YDAudioControlPannelMgr.m
//  SportsBar
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import "YDAudioControlPannelMgr.h"
#import <UIKit/UIKit.h>
#import "YDControlPannelController.h"
#import "RCDraggableButton.h"
#import "YDBgMediaMgr.h"
#import "YDPannelINfo.h"
#import <AVFoundation/AVFoundation.h>
#import "YDAudioSlider.h"

@interface YDAudioControlPannelMgr ()

@property (nonatomic, strong) UIWindow *pannelWindow;

@property (nonatomic, strong) YDControlPannelController *rootVc;

@property (nonatomic, strong) NSString *titie;
@property (nonatomic, strong) NSString *currentTimeStr;
@property (nonatomic, strong) NSString *total;

@property (nonatomic, strong) UITapGestureRecognizer *tabRecognizer;

@property (nonatomic, assign) BOOL hasRegisterTouch;

@property (nonatomic, strong) NSTimer *timer; // 1s 更新一次

@end

@implementation YDAudioControlPannelMgr

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
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    _tabRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTabWindowClick:)];
}

- (void)registerOnceMainWindowTouch {
    
    if (_hasRegisterTouch) {
        return;
    }
    
    if (_pannelWindow && _tabRecognizer) {
        [_pannelWindow addGestureRecognizer:_tabRecognizer];
        _hasRegisterTouch = YES;
    }
}

- (void)onTabWindowClick:(UIGestureRecognizer *)recognier {
    NSLog(@"tab getsture ");
    self.hideHoverPannel(YES);
    _hasRegisterTouch = NO;
}

- (void)removeMainWindowTabGesture {
    if (_pannelWindow && _tabRecognizer) {
        [_pannelWindow removeGestureRecognizer:_tabRecognizer];
        _hasRegisterTouch = NO;
    }
}


#pragma mark -- nomal methods 
- (BOOL)hasCreate {
    if (self.pannelWindow) {
        return YES;
    }
    return NO;
}

- (BOOL)isPannelHidden {
    if (self.pannelWindow.isHidden) {
        return YES;
    }
    return NO;
}

#pragma mark -- block methods

- (YDAudioControlPannelMgr *(^)(CGRect rect))createAControlPannel {
    __weak typeof (self) wSelf = self;
   return ^(CGRect rect){
       __strong typeof (wSelf) strongSelf = wSelf;
       strongSelf.rootVc = [YDControlPannelController new];
       strongSelf.pannelWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 20.f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-20.f)];
       strongSelf.pannelWindow.windowLevel = NSIntegerMax;
       strongSelf.pannelWindow.rootViewController = strongSelf.rootVc;
       [strongSelf.pannelWindow makeKeyAndVisible];
       
//       configure extension
       [strongSelf registerOnceMainWindowTouch];
       [strongSelf registerEvents];
       
        return self;
    };
}

- (void)registerEvents {
    __weak typeof (self) wSelf = self;
   
//    close evnet
    if (self.rootVc) {
        self.rootVc.closeBlock = ^{
            [wSelf removeMainWindowTabGesture];
            [[YDBgMediaMgr shared] setHiddenHoverBtn:YES];
            [[YDBgMediaMgr shared] stop];
            
            [wSelf.rootVc animationDisAppearWithBlock:^{
                wSelf.pannelWindow.hidden = YES;
                wSelf.pannelWindow = nil;
            }]; 
        };
        
        self.rootVc.progressSlider.valueBeginChagneBlock = ^{
            NSLog(@"destroy the timer");
            [[YDBgMediaMgr shared] destroyTimer];
        };
        
        self.rootVc.progressSlider.valueChangeBlock = ^(float value) {
            NSLog(@"change the value: %f",value);
            [[YDBgMediaMgr shared] playAtTime:value];
        };
        
        
        self.rootVc.nextBlock = ^{
            [[YDBgMediaMgr shared] nextTrack:^(YDPannelINfo *info) {
                NSLog(@" 下一首歌");
                wSelf.rootVc.controlPanelTitle(info.title);
            }];
        };
        
        self.rootVc.previousBlock = ^{
            [[YDBgMediaMgr shared] previousTrack:^(YDPannelINfo *info) {
                NSLog(@"上一首歌");
                wSelf.rootVc.controlPanelTitle(info.title);
            }];
        };
        
        self.rootVc.putAwayBlock = ^{
            wSelf.pannelWindow.hidden = YES;
        };
        
        self.rootVc.playOrPauseBlock = ^{
            NSLog(@"点击了暂停与播放按钮");
           [[YDBgMediaMgr shared] playOrPause:^(YDPannelINfo *info) {
               [YDAudioControlPannelMgr shared].rootVc.updatePlayOrPause(info.isPlaying);
           }];
        };
        
        self.rootVc.titleTapBlock = ^{
            NSLog(@"跳转链接");
        };
    }
}

- (YDAudioControlPannelMgr *(^)(UIColor *color))bgColor {
    __weak typeof (self) wSelf = self;
    return ^(UIColor *color) {
        wSelf.rootVc.view.backgroundColor = color;
        return self;
    };
}

- (YDAudioControlPannelMgr *(^)(BOOL hidden))hideHoverPannel {
    __weak typeof (self) wSelf = self;
    return ^(BOOL hidden) {
        if (!wSelf.pannelWindow) {
            return self;
        }
        wSelf.pannelWindow.hidden = hidden;
        return self;
    };
}

- (void)updateViewWithInfo:(YDPannelINfo *)info {
    if (!_rootVc) {
        return;
    }
    self.rootVc.controlPanelTitle(info.title).controlPanelTotalTime(info.totalTime).controlPanelCurrentTime(info.currentTime).updateProgressView();
    
}

- (void)updateProgressViewWithInfo:(YDPannelINfo *)info {
    if (!_rootVc) {
        return;
    }
    _rootVc.controlPanelCurrentTime(info.currentTime).controlPanelTotalTime(info.totalTime).updateProgressView();
}

@end
