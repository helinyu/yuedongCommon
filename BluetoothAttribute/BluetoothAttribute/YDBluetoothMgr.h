//
//  YDBluetoothMgr.h
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/9.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDDefine.h"
@class YDPeripheralInfo;
@class CBPeripheral;
@class CBService;
@class CBUUID;
@class CBCharacteristic;

@interface YDBluetoothMgr : NSObject

typedef void (^ConnectionStateBlock)(ConnectionState state);
typedef NSArray<CBService *>* CBServices;
typedef NSArray<CBUUID *> * CBUUIDs;
typedef void(^YDServicesBlock)(CBServices services);
typedef void(^YDCharacteristicBlock)(CBCharacteristic *characteristic);
typedef YDBluetoothMgr* (^YDBluetoothMgrNoneParamBlock)(void);

+ (YDBluetoothMgrNoneParamBlock)shared;
- (YDBluetoothMgrNoneParamBlock)loadBase;
- (YDBluetoothMgrNoneParamBlock)initCentralManager;
- (YDBluetoothMgrNoneParamBlock)scanPeripherals;
- (YDBluetoothMgrNoneParamBlock)stopScanPeripheral;
- (YDBluetoothMgr *(^)(NSInteger index))selectedPeriphealWithIndex;
- (YDBluetoothMgr *(^)(CBPeripheral *peripheral))startConnectSelectedPeripheral;
- (YDBluetoothMgrNoneParamBlock)connectionState:(void (^)(BOOL state))stateCallback;
- (YDBluetoothMgr *(^)(CBUUIDs uuids))discoverServices;
- (YDBluetoothMgr *(^)(CBUUIDs uuids,CBService *service))discoverCharacteristic;

@property (nonatomic, copy) ConnectionStateBlock connectionStateBlock;
@property (nonatomic, copy) YDServicesBlock servicesBlock;
@property (nonatomic, copy) YDCharacteristicBlock characteristicCallback;

@property (nonatomic, strong, readonly) NSMutableArray<YDPeripheralInfo *> *peripheralInfos;
@property (nonatomic, strong, readonly) CBPeripheral *selectedPeripheral;


@end
