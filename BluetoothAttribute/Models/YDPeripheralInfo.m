//
//  YDPeripheralInfo.m
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/8.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDPeripheralInfo.h"

@implementation YDPeripheralInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (YDPeripheralInfo *)peripheral:(CBPeripheral *)peripheral RSSI:(NSNumber *)rssi advertisementData:(NSDictionary<NSString *, id> *)advertisementData {
    YDPeripheralInfo *info = [YDPeripheralInfo new];
    info.peripheral = peripheral;
    info.RSSI = rssi;
    info.advertisementData = advertisementData;
    return info;
}

@end
