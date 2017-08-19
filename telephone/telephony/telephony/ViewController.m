//
//  ViewController.m
//  telephony
//
//  Created by Aka on 2017/8/18.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTSubscriber.h>
#import <CoreTelephony/CTCellularData.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTSubscriberInfo.h>

@interface ViewController ()

@property (nonatomic, strong) CTCallCenter *callCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"carrier 信息" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(test0) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 100, 100, 40);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRadioAccessTechnology:) name:CTRadioAccessTechnologyDidChangeNotification object:nil];
    [self test1];
    
    UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [subBtn setTitle:@"CTTelephonyNetworkInfo" forState:UIControlStateNormal];
    [subBtn addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subBtn];
    subBtn.frame = CGRectMake(120, 100, 100, 40);[
    [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSubscriberTokenRefreshedNotify:) name:CTSubscriberTokenRefreshed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onConnectInvalidateNotify:) name:@"kCTConnectionInvalidatedNotification" object:nil];
    
//    权限
    [self test3];
    
//    call hander
    [self test4];
}

//获取运营商
//中国移动 00 02 07
//中国联通 01 06
//中国电信 03 05
//中国铁通 20
- (void)test0 {
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        NSLog(@"carrier is nil");
        return;
    }
    
    NSString *countryCode = [carrier mobileCountryCode];
    NSString *networkCode = [carrier mobileNetworkCode];
    
    BOOL iscontryCode = [carrier isoCountryCode];
    BOOL allowVOIP  = [carrier allowsVOIP];
    NSString *name = [carrier carrierName];
    NSLog(@"countryCode : %@, networkCode : %@, iscountryCode:%d, allowVOIP:%d, carrier name: %@",countryCode,networkCode,iscontryCode,allowVOIP,name);
    
}

- (void)test1 {
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    info.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier * carrier) {
//         这里就可以执行test0 的操作了
        NSString *countryCode = [carrier mobileCountryCode];
        NSString *networkCode = [carrier mobileNetworkCode];
        BOOL iscontryCode = [carrier isoCountryCode];
        BOOL allowVOIP  = [carrier allowsVOIP];
        NSString *name = [carrier carrierName];
        NSLog(@"block countryCode : %@, networkCode : %@, iscountryCode:%d, allowVOIP:%d, carrier name: %@",countryCode,networkCode,iscontryCode,allowVOIP,name);
    };
}

- (void)test2 {
    CTSubscriber *subscriber = [CTSubscriberInfo subscriber];
    NSData *datas  = subscriber.carrierToken;
    NSLog(@"token dats :%@",datas);
}

- (void)test3 {
    CTCellularData *cellularData = [CTCellularData new];
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        switch (state) {
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"状态不知道");
                break;
            case kCTCellularDataRestricted:
            {
                NSLog(@"严格的");
            }
                break;
            case kCTCellularDataNotRestricted:
            {
                NSLog(@"不严格的");
            }
            default:
                break;
        }
    };
}

- (void)test4 {
    _callCenter = [CTCallCenter new];
    NSSet<CTCall*> *calls = _callCenter.currentCalls;
    __weak typeof (self) wSelf = self;
    _callCenter.callEventHandler = ^(CTCall * call) {
        NSLog(@"call : %@",call);
        NSSet<CTCall*> *calls = wSelf.callCenter.currentCalls;
    };

}

// 未来可能会被废弃掉，不会使用功能 （token不知道要干嘛使用的）
- (void)onSubscriberTokenRefreshedNotify:(NSNotification *)noti {
    NSLog(@"noti obj :%@",noti.object);
}

- (void)onRadioAccessTechnology:(NSNotification *)noti {
    NSLog(@"notificaiton : %@",noti.object);
}

- (void)onConnectInvalidateNotify:(NSNotification *)noti {
    NSLog(@"ConnectInvalidate : %@",noti.object);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
