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

@interface YDAudioControlPannelMgr ()

@property (nonatomic, strong) UIWindow *pannelWindow;

@property (nonatomic, strong) YDControlPannelController *rootVc;

@property (nonatomic, strong) NSString *titie;
@property (nonatomic, strong) NSString *currentTimeStr;
@property (nonatomic, strong) NSString *leaveTimeStr;

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

- (YDAudioControlPannelMgr *(^)(CGRect rect))createAControlPannel {
    __weak typeof (self) wSelf = self;
   return ^(CGRect rect){
       __strong typeof (wSelf) strongSelf = wSelf;
       strongSelf.rootVc = [YDControlPannelController new];
       strongSelf.pannelWindow = [[UIWindow alloc] initWithFrame:rect];
       strongSelf.pannelWindow.windowLevel = NSIntegerMax;
       strongSelf.pannelWindow.rootViewController = strongSelf.rootVc;
       [strongSelf.pannelWindow makeKeyAndVisible];
        return self;
    };
}

- (YDAudioControlPannelMgr *(^)(UIColor *color))bgColor {
    __weak typeof (self) wSelf = self;
    return ^(UIColor *color) {
        wSelf.rootVc.view.backgroundColor = color;
        return self;
    };
}


@end
