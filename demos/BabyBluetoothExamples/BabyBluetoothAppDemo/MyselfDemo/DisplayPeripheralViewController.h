//
//  DisplayPeripheralViewController.h
//  MyselfDemo
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 刘彦玮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BabyBluetooth;
@class CBPeripheral;

@interface DisplayPeripheralViewController : UIViewController

@property (nonatomic, strong) BabyBluetooth *blueTooth;

@property (nonatomic, strong) NSMutableArray *services;
@property (nonatomic, strong) CBPeripheral *currPeripheral;

@end
