//
//  YDBluetoothWebView.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIWebView;
@class WKWebView;

@interface YDBluetoothWebView : UIView

@property (nonatomic, strong, readonly) id webView;
@property (nonatomic, strong, readonly) UIWebView *lwebView;
@property (nonatomic, strong, readonly) WKWebView *hwebView;

#pragma mark -- action & block
/*
 * @method : requestWithUrl
 * @param  : url the webVC's link request 
 */
- (YDBluetoothWebView *(^)(NSString *urlString))requestWithUrl;

@end
