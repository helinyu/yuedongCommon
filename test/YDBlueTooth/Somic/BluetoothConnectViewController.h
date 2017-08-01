//
//  BluetoothConnectViewController.h
//  SOMICS3
//
//  Created by mac-somic on 2017/4/21.
//  Copyright © 2017年 mac-somic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef void(^blueBlock)(CBPeripheral *peripheral);

@interface BluetoothConnectViewController : UIViewController

@property (nonatomic, strong) CBPeripheral *peripheral;

- (instancetype)initBlueVCWithArray:(NSArray *)array;

@end
