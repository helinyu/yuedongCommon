//
//  YDBluetoothWebViewMgr.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/27.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WebViewJavascriptBridge;
@class YDBluetoothWebView;

@interface YDBluetoothWebViewMgr : NSObject

+ (instancetype)shared;

- (YDBluetoothWebViewMgr *(^)(NSString *urlString))webUrl;

@property (nonatomic, strong, readonly) NSString *urlString;


- (void)loadSerachBlueDatas;

- (void)registerHandler;

- (void)configureWithWebView:(YDBluetoothWebView *)view;

@end
