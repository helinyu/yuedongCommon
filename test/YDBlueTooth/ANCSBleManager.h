//
//  S3Manager.h
//  YDOpenHardwareThirdPart
//
//  Created by mac-somic on 2017/4/25.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface ANCSBleManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

+ (instancetype)shareManager;

@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCentralManager *manager;

@property (strong, nonatomic, readonly ) NSArray *nDevices;

//蓝牙设备ID
@property (strong, nonatomic ) NSString *deviceId;
//第三方标识名称
@property (strong, nonatomic ) NSString *plugName;
//悦动圈用户id
@property (strong, nonatomic ) NSString *user_id;
//悦动圈提供的设备id
@property (strong, nonatomic ) NSString *device_identify;

@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;


- (void)scanForPeripherals;

- (void)connectS3Bluetooth;

@end
