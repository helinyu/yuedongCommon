//
//  YDBlueToothWebViewController.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDBlueToothWebViewController : UIViewController

- (YDBlueToothWebViewController *(^)(NSString *urlString))webUrl;

@end
