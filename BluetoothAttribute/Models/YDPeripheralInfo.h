//
//  YDPeripheralInfo.h
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/8.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBPeripheral;

//for contain the info to display the peripheral 
@interface YDPeripheralInfo : NSObject
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) NSNumber *RSSI;
//@property (nonatomic, strong) NSUUID *uuid;
@property (nonatomic, strong) NSDictionary<NSString *, id> *advertisementData;

+ (YDPeripheralInfo *)peripheral:(CBPeripheral *)peripheral RSSI:(NSNumber *)rssi advertisementData:(NSDictionary<NSString *, id> *)advertisementData;

@end
