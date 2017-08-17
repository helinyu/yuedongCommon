//
//  YDSettingViewController.m
//  test_yuedong_band
//
//  Created by Aka on 2017/8/17.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDSettingViewController.h"
#import <CoreTelephony/CTCallCenter.h>
#import "YDBluetoothWebViewMgr+WriteDatas.h"

@interface YDSettingViewController ()

@property (nonatomic, strong) CTCallCenter *callCenter;

@property (nonatomic, assign) BOOL isCall;

@end

@implementation YDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self comInit];
    [self callHandle];
    
}

- (void)callHandle {
    _callCenter = [CTCallCenter new];
    __weak typeof (self) weakSelf = self;
    _callCenter.callEventHandler = ^(CTCall *call) {
        NSString *callDescription = [NSString stringWithFormat:@"%@",call];
        NSLog(@"callDescription == %@",callDescription);
        NSArray *strarray0 = [callDescription componentsSeparatedByString:@"]"];
        NSString *sub0 = strarray0[0];
        NSArray *strarray1 = [sub0 componentsSeparatedByString:@"["];
        NSString *callState = strarray1[1];
        NSLog(@"callState == %@",callState);
        if ([callState isEqualToString:@"CTCallStateIncoming"] || [callState isEqualToString:@"CTCallStateConnected"]) {
            weakSelf.isCall = YES;
            [weakSelf.webViewMgr telRemind];
        }else {
            weakSelf.isCall = NO;
        }
    };
}

- (void)comInit {
    UIButton *alarmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [alarmBtn setTitle:@"设置闹钟" forState:UIControlStateNormal];
    [alarmBtn addTarget:self action:@selector(onClockClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alarmBtn];
    alarmBtn.frame = CGRectMake(0, 100, 100, 30);
    
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [telBtn setTitle:@"来电提醒" forState:UIControlStateNormal];
    [telBtn addTarget:self action:@selector(onTelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telBtn];
    telBtn.frame = CGRectMake(110, 100, 100, 100);
    
    UIButton *loseFindBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [loseFindBtn setTitle:@"寻找我的手环" forState:UIControlStateNormal];
    [loseFindBtn addTarget:self action:@selector(onLoseFindClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loseFindBtn];
    loseFindBtn.frame = CGRectMake(220, 100, 100, 30);

    UIButton *recoverBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [recoverBtn setTitle:@"恢复厂商设置" forState:UIControlStateNormal];
    [recoverBtn addTarget:self action:@selector(onRescoverFactorySettingClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recoverBtn];
    recoverBtn.frame = CGRectMake(0, 240, 100, 30);

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"断开连接" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(onCancelConnectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    cancelBtn.frame = CGRectMake(210, 240, 100, 30);


}

- (void)onClockClick {
    
}

- (void)onTelClick {
    
}

- (void)onLoseFindClick {
    
}

- (void)onRescoverFactorySettingClick {
    
}

- (void)onCancelConnectClick {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
