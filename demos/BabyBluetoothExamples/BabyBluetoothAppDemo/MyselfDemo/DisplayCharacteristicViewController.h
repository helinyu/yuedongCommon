//
//  DisplayCharacteristicViewController.h
//  MyselfDemo
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 刘彦玮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBCharacteristic;
@class CBPeripheral;
@class BabyBluetooth;

@interface DisplayCharacteristicViewController : UIViewController

@property (nonatomic, strong) BabyBluetooth *bluetooth;
@property (nonatomic, strong) NSMutableArray *sect;
@property (nonatomic, strong) NSMutableArray *readValueArray;
@property (nonatomic, strong) NSMutableArray *descriptors;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CBCharacteristic * characteristic;
@property (nonatomic, strong) CBPeripheral *currPeripheral;

@end
