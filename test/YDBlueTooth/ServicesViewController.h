//
//  ServicesViewController.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDBlueToothMgr;

@interface ServicesViewController : UIViewController

- (ServicesViewController *(^)(YDBlueToothMgr *paramMgr))vcMgr;

@end
