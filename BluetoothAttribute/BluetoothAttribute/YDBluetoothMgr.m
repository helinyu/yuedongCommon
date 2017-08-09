//
//  YDBluetoothMgr.m
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/9.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDBluetoothMgr.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "YDPeripheralInfo.h"
#import "YDConstant.h"

@interface YDBluetoothMgr ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong, readwrite) CBCentralManager *centralManger;
@property (nonatomic, strong, readwrite) CBPeripheral *selectedPeripheral;
@property (nonatomic, strong, readwrite) NSArray *selectedPeripheralServices;
@property (nonatomic, strong, readwrite) NSMutableArray<NSUUID *> *connectedPeripheralsdentifiers;
@property (nonatomic, strong, readwrite) NSMutableArray<CBUUID *> *connectedservicesUUIDs;
@property (nonatomic, strong, readwrite) CBUUID *discoverServiceUUID;
@property (nonatomic, strong, readwrite) NSMutableArray<YDPeripheralInfo *> *peripheralInfos;

@property (nonatomic, assign, readwrite) CBCentralManagerState *state;

@end

@implementation YDBluetoothMgr

#pragma mark -- custom methods

+ (YDBluetoothMgrNoneParamBlock)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return ^(void) {
        return singleton;
    };
}

- (void)onRetriveIdentifierClicked {
    if (_connectedPeripheralsdentifiers.count >0) {
        NSArray<CBPeripheral *> *connectedPeripherals =[_centralManger retrievePeripheralsWithIdentifiers:_connectedPeripheralsdentifiers];
        [connectedPeripherals enumerateObjectsUsingBlock:^(CBPeripheral * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CBPeripheral *peripheral = (CBPeripheral *)obj;
            NSLog(@"peripheral name : %@",peripheral.name);
        }];
    }
}

- (void)onRetriveServicesClicked {
    if (_connectedservicesUUIDs.count >0) {
        NSArray<CBPeripheral *> *connectedPeripherals = [_centralManger retrieveConnectedPeripheralsWithServices:_connectedservicesUUIDs];
        [connectedPeripherals enumerateObjectsUsingBlock:^(CBPeripheral * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CBPeripheral *peripheral = (CBPeripheral *)obj;
            NSLog(@"peripheral name : %@",peripheral.name);
        }];
    }
}

- (void)onCancelConnectedClicked {
    if (_selectedPeripheral) {
        [_centralManger cancelPeripheralConnection:_selectedPeripheral];
    }
}

- (YDBluetoothMgrNoneParamBlock)loadBase {
    _connectedPeripheralsdentifiers = @[].mutableCopy;
    _connectedservicesUUIDs = @[].mutableCopy;
    _discoverServiceUUID = [CBUUID UUIDWithString:@"0xFFF0"];
    _peripheralInfos = @[].mutableCopy;
    return ^(void) {
        return self;
    };
}

- (YDBluetoothMgrNoneParamBlock)initCentralManager {
    NSDictionary *centralInitOptions = @{CBCentralManagerOptionShowPowerAlertKey:@(YES),CBCentralManagerOptionRestoreIdentifierKey:@"restoreidentifier"};
    _centralManger = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(0, 0) options:centralInitOptions];
    return ^(void) {
        return self;
    };
}

- (YDBluetoothMgrNoneParamBlock)scanPeripherals {
//  NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)};
    if (_centralManger.state == CBManagerStatePoweredOn) {
        [_centralManger scanForPeripheralsWithServices:nil options:nil];
    }else{
        NSLog(@"please open the bluetooth");
    }
    return ^(void) {
        return self;
    };
}

- (YDBluetoothMgrNoneParamBlock)stopScanPeripheral {
    if (_centralManger.isScanning) {
        [_centralManger stopScan];
    }
    return ^(void) {
        return self;
    };
}

- (YDBluetoothMgr *(^)(NSInteger index))selectedPeriphealWithIndex {
    __weak typeof (self) wSelf = self;
    return ^(NSInteger index) {
        __strong typeof (wSelf) strongSelf = wSelf;
        strongSelf.selectedPeripheral = strongSelf.peripheralInfos[index].peripheral;
        [[NSUserDefaults standardUserDefaults] setObject:strongSelf.selectedPeripheral.identifier.UUIDString forKey:YDPerppheralSelectedPeripheralUUIDString];
        return self;
    };
}

- (YDBluetoothMgr *(^)(CBPeripheral *peripheral))startConnectSelectedPeripheral {
    __weak typeof (self) wSelf = self;
    return ^(CBPeripheral *peripheral) {
        __strong typeof (wSelf) strongSelf = wSelf;
        if (peripheral) {
            strongSelf.selectedPeripheral = peripheral;
        }
        NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@(YES),CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES),CBConnectPeripheralOptionNotifyOnNotificationKey:@(YES)};
        [_centralManger connectPeripheral:strongSelf.selectedPeripheral options:connectOptions];
        return self;
    };
}

- (YDBluetoothMgr *(^)(CBUUIDs uuids))discoverServices {
    __weak typeof (self) wSelf = self;
    return ^(CBUUIDs uuids){
        wSelf.selectedPeripheral.delegate = self;
        [wSelf.selectedPeripheral discoverServices:uuids];
        return self;
    };
}

- (YDBluetoothMgr *(^)(CBUUIDs uuids,CBService *service))discoverCharacteristic {
    __weak typeof (self) wSelf = self;
    return ^(CBUUIDs uuids,CBService *service) {
        [wSelf.selectedPeripheral discoverCharacteristics:uuids forService:service];
        return self;
    };
}

//central manager delegate
#pragma mark -- central manager 大体的
#pragma mark -- CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
        
    }else{
        NSLog(@"请打开蓝牙设备");
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSLog(@"peripheral name is ; %@",peripheral.name);
    if (peripheral.name.length <=0) {
        return ;
    }
    
    if (_peripheralInfos.count <= 0) {
        YDPeripheralInfo *infoItem = [YDPeripheralInfo peripheral:peripheral RSSI:RSSI advertisementData:advertisementData];
        [_peripheralInfos addObject:infoItem];
    }else{
        BOOL hasStore = NO;
        for (NSInteger index =0; index <_peripheralInfos.count; index++) {
            YDPeripheralInfo *storePeripheralInfo = _peripheralInfos[index];
            if ([storePeripheralInfo.peripheral.name isEqualToString:peripheral.name] && [storePeripheralInfo.peripheral.identifier isEqual:peripheral.identifier]) {
                //                [_peripheralInfos removeObject:storePeripheral];
                //                [_peripheralInfos insertObject:peripheral atIndex:index];
                hasStore = YES;
                break;
            }
        }
        if (!hasStore) {
            YDPeripheralInfo *infoItem = [YDPeripheralInfo peripheral:peripheral RSSI:RSSI advertisementData:advertisementData];
            [_peripheralInfos addObject:infoItem];
        }
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:YDPerppheralNeedReload object:nil];

}

//存储了上一次已经连接的内容,存储了之后需要怎么进行处理？
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    NSLog(@"dict : %@",dict);
    
    NSDictionary *scanOptions = dict[CBCentralManagerRestoredStateScanOptionsKey];
    if (_centralManger.state != CBManagerStatePoweredOn) {
        _centralManger = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(0, 0) options:scanOptions];
    }

    NSArray *serviceUUIDs = dict[CBCentralManagerRestoredStateScanServicesKey];
    NSDictionary *serivceOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)};
    [_centralManger scanForPeripheralsWithServices:serviceUUIDs options:serivceOptions];
    
    NSArray *storePeripherals = dict[CBCentralManagerRestoredStatePeripheralsKey];
    [storePeripherals enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CBPeripheral *peripheral = (CBPeripheral *)obj;
        [_centralManger cancelPeripheralConnection:peripheral];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"selectedPeripheralUUIDString"];
    }];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    self.connectionStateBlock(ConnectionStateSuccess);
    NSLog(@"did connect peripheral name : %@ , identifier : %@",peripheral.name,peripheral.identifier);
    [_connectedPeripheralsdentifiers addObject:peripheral.identifier]; // store for retrive
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"fail to connnect");
    self.connectionStateBlock(ConnectionStateFailure);
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"did disconnect peripheral : %@",error);
    self.connectionStateBlock(ConnectionStateDisconnect);
    [_connectedPeripheralsdentifiers removeObject:peripheral.identifier];
}

#pragma mark -- 外设的信息的读取，完全是CBPeripheral类对应的内容（具体）
#pragma mark -- peripheral delegate

//——————————peripheral内容上面的处理
// 外设连接的时候法发生了改变 （应该是新的外设链接上了，和didconnect应该是同样等级的delegate）
- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral NS_AVAILABLE(10_9, 6_0) {
    NSLog(@"peripheralDidUpdateName change: %@",peripheral.name);
    //    连接改变了之后发生了什么改变？ 选择另外一个蓝牙外设的时候，就会被调用
}
//—————————————— 服务发生改变（也就是这个内容已经没有了作用）
//service 内容发生了改变 (应该是service变为不可以使用的的时候会被调用)
- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices NS_AVAILABLE(10_9, 7_0); {
    NSLog(@"didModifyServices");
    [invalidatedServices enumerateObjectsUsingBlock:^(CBService * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"didModifyServices : %@",obj);
    }];
}

/////___ rssi 的内容处理
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(nullable NSError *)error NS_DEPRECATED(10_7, 10_13, 5_0, 8_0) {
    NSLog(@"peripheralDidUpdateRSSI: %@",peripheral.RSSI);
    [peripheral readRSSI];
}

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(nullable NSError *)error NS_AVAILABLE(10_13, 8_0) {
    NSLog(@"did read rssi : %@",RSSI);
}

//-------—— service上面的处理
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    if (error) {
        NSLog(@"dicover peripheral services error : %@",error);
        return;
    }
    self.servicesBlock(peripheral.services);

}

//发现包含在内的service的内容
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"didDiscoverIncludedServicesForService : %@",service);
}

//—————————— characteristic上面的内容处理 （发现）
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    if (error) {
        NSLog(@"error : %@",error);
        return;
    }
    
    //    这一段进行过滤一下
    [service.characteristics enumerateObjectsUsingBlock:^(CBCharacteristic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"didDiscoverCharacteristicsForService ,characteristic : %@ , idx :%ld ,stop:%d",obj,idx,*stop);
        
        if ([obj.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]) {
            Byte bytes[] ={0x72};
            NSData *datas = [[NSData alloc] initWithBytes:bytes length:1];
            [peripheral writeValue:datas forCharacteristic:obj type:CBCharacteristicWriteWithResponse];
        }else{
            [peripheral setNotifyValue:YES forCharacteristic:obj];
        }
        
    }];
}

//———————————— 读写 通知 characteristic
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"读取数据吧： 还是更新？ didUpdateValueForCharacteristic: %@",characteristic);
    //    读取的数据
    //    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF2"]]) {
    //        NSLog(@"读取FFF2数据");
    //    }else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF3"]]) {
    //        NSLog(@"读取fff3的数据");
    //    }else{}
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error) {
        NSLog(@"write error");
        return;
    }
    NSLog(@"写入的数据：didWriteValueForCharacteristic %@",characteristic);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error) {
        NSLog(@"error : %@",error);
        return;
    }
    
    if (characteristic.isNotifying) {
        NSLog(@"didUpdateNotificationStateForCharacteristic: %@",characteristic);
        [peripheral readValueForCharacteristic:characteristic];
    }else{
        NSLog(@"notification stoped  ");
        [_centralManger cancelPeripheralConnection:peripheral];
    }
    
}

//———————————— characteristic里面的descriptor上面的内容
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"didDiscoverDescriptorsForCharacteristic: %@",characteristic);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    NSLog(@"didUpdateValueForDescriptor: %@",descriptor);
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    NSLog(@"didWriteValueForDescriptor: %@",descriptor);
}

//canSendWriteWithoutResponse 从NO变成YES的时候
- (void)peripheralIsReadyToSendWriteWithoutResponse:(CBPeripheral *)peripheral {
    
}

//L2CAP （数据重发等等）
- (void)peripheral:(CBPeripheral *)peripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel *)channel error:(nullable NSError *)error {
    
}

@end
