//
//  YDBluetoothWebView.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDBluetoothWebView : UIView


#pragma mark -- action & block
/*
 * @method : requestWithUrl
 * @param  : url the webVC's link request 
 */
- (YDBluetoothWebView *(^)(NSURL *url))requestWithUrl;

@end
