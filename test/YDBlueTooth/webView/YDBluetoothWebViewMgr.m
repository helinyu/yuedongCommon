//
//  YDBluetoothWebViewMgr.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/27.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDBluetoothWebViewMgr.h"
#import "YDBlueToothMgr.h"
#import "YDBluetoothWebView.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "WebViewJavascriptBridge.h"

@interface YDBluetoothWebViewMgr ()

@property (nonatomic, strong) NSArray *blueDataSouces;

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) YDBlueToothMgr *bluetoothMgr;

@end


@implementation YDBluetoothWebViewMgr

- (void)loadSerachBlueDatas {
    
    __weak typeof (self) wSelf = self;
    _bluetoothMgr = [YDBlueToothMgr shared];
    _bluetoothMgr.startScan().scanCallBack = ^(NSArray<CBPeripheral *> *peripherals) {
        
        CBPeripheral *peri = peripherals[0];
        NSString *name = peri.name;
        if ([name isEqualToString:@"S3"]) {
            [wSelf.bridge callHandler:@"onperipheral" data:name responseCallback:^(id responseData) {
                _bluetoothMgr.stopScan();
                NSLog(@"respo: %@",responseData);
            }];
        }
      
    };
    
}

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

#pragma mark -- custom block for configuring attribute

- (YDBluetoothWebViewMgr *(^)(NSString *urlString))webUrl {
    __weak typeof (self) wSelf = self;
    return ^(NSString *urlString){
        if (urlString.length > 0) {
            NSString *linkUrlString = urlString;
            wSelf.urlString = urlString;
            // configure the whole by the host url
//            wSelf.url = [NSURL URLWithString:linkUrlString];
        }
        return self;
    };
}

@end
