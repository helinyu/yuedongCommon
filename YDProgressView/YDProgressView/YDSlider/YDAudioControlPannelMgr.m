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
#import "XHFloatWindow.h"
#import "YDBgMediaMgr.h"
#import "YDPannelINfo.h"
#import <AVFoundation/AVFoundation.h>

@interface YDAudioControlPannelMgr ()

@property (nonatomic, strong) UIWindow *pannelWindow;

@property (nonatomic, strong) YDControlPannelController *rootVc;

@property (nonatomic, strong) NSString *titie;
@property (nonatomic, strong) NSString *currentTimeStr;
@property (nonatomic, strong) NSString *total;

@property (nonatomic, strong) UITapGestureRecognizer *tabRecognizer;

@property (nonatomic, assign) BOOL hasRegisterTouch;

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
    _hasRegisterTouch = YES;
    UIWindow *mainWindow = [UIApplication sharedApplication].windows.firstObject;
    [mainWindow addGestureRecognizer:_tabRecognizer];
}

- (void)onTabWindowClick:(UIGestureRecognizer *)recognier {
    NSLog(@"tab getsture ");
    self.hideHoverPannel(YES);
    _hasRegisterTouch = NO;
}

- (void)removeMainWindowTabGesture {
    UIWindow *mainWindow = [UIApplication sharedApplication].windows.firstObject;
    [mainWindow removeGestureRecognizer:_tabRecognizer];
    _hasRegisterTouch = NO;
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
       strongSelf.pannelWindow = [[UIWindow alloc] initWithFrame:rect];
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
            wSelf.pannelWindow.hidden = YES;
            wSelf.pannelWindow = nil;
            [XHFloatWindow xh_setHideWindow:YES];
            [[YDBgMediaMgr shared] stop];
        };
        
        self.rootVc.changeValueBlock = ^(float value) {
            NSLog(@"value : %f",value);
            [[YDBgMediaMgr shared] playAtTime:value];
        };
        
        self.rootVc.nextBlock = ^{
            [[YDBgMediaMgr shared] nextTrack:^(YDPannelINfo *info) {
                
            }];
        };
        
        self.rootVc.previousBlock = ^{
            [[YDBgMediaMgr shared] previousTrack:^(YDPannelINfo *info) {
                
            }];
        };
        
        self.rootVc.playOrPauseBlock = ^{
           [[YDBgMediaMgr shared] playOrPause:^(YDPannelINfo *info) {
               [YDAudioControlPannelMgr shared].rootVc.updatePlayOrPause(info.isPlaying);
           }];
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
        if (wSelf.pannelWindow.isHidden) {
            [wSelf removeMainWindowTabGesture];
        }else{
            [self registerOnceMainWindowTouch];
        }
        
        return self;
    };
}

- (void)updateWithInfo:(YDPannelINfo *)info {
    self.rootVc.controlPanelTitle(info.title).controlPanelTotalTime(info.totalTime).controlPanelCurrentTime(info.currentTime).updateView();
    
}

@end
