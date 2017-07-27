//
//  YDBlueToothWebViewController.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDBluetoothWebViewMgr;

@interface YDBlueToothWebViewController : UIViewController

@property (nonatomic, strong) YDBluetoothWebViewMgr *webViewMgr;

- (YDBlueToothWebViewController *(^)(NSString *titleString))webTittle;

@end
