//
//  YDMainContentViewController.h
//  test_yuedong_band
//
//  Created by Aka on 2017/8/17.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "YDBluetoothWebViewMgr.h"

@interface YDMainContentViewController : UIViewController

@property (nonatomic, strong) CBPeripheral *choicePeripheral;
@property (nonatomic, strong) YDBluetoothWebViewMgr *mgr;

@end
