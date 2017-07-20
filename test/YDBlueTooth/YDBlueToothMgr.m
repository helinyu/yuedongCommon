//
//  YDBlueToothMgr.m
//  test
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDBlueToothMgr.h"
#import "BabyBluetooth.h"
#import "SVProgressHUD.h"

@interface YDBlueToothMgr ()

@property (nonatomic, strong) BabyBluetooth *bluetooth;

/*
 * param : peripherals , memory store peripheral to display & for selected
 * discussion : this attribute must be implement for selected and search service enable by it ,if not ,it will be not find the services
 */
@property (nonatomic, strong) NSMutableArray<CBPeripheral *> *peripherals;

@property (nonatomic, strong) NSMutableArray<CBService *> *connectedPeripheralServices;

@property (nonatomic, assign, readwrite) NSInteger currentIndex;
@property (nonatomic, strong, readwrite) CBPeripheral *currentPeripheral;


@end

//static NSString *const connectionChannel = @"connection.channel";

@implementation YDBlueToothMgr

#pragma mark -- system function
- (void)dealloc {
    [self quitConnected];
}


#pragma mark -- all delegate block

- (void)babyDelegate {
    
    __weak typeof  (self) wSelf = self;
    BabyRhythm *rhythm = [BabyRhythm new];
    
    [_bluetooth setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            [SVProgressHUD showInfoWithStatus:@"设备打开成功，开始扫描设备"];
            NSLog(@"设备打开成功，开始扫描蓝牙设备");
        }
    }];
    
//    [_bluetooth setBlockOnCentralManagerDidUpdateStateAtChannel:connectionChannel block:^(CBCentralManager *central) {
//        if (central.state == CBManagerStatePoweredOn) {
//            [SVProgressHUD showInfoWithStatus:@"指定channel设备打开成功，开始扫描设备"];
//            NSLog(@"设备打开成功，开始扫描蓝牙设备");
//        }
//    }];
    
    [_bluetooth setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        BOOL hasStored = NO;
        for (CBPeripheral *item in wSelf.peripherals) {
            if ([item.name isEqualToString:peripheral.name]) {
                hasStored = YES;
                break;
            }
        }
        if (!hasStored) {
            [wSelf.peripherals addObject:peripheral];
            NSLog(@"find peripheral name is : %@",peripheral.name);
        }
        !wSelf.scanCallBack?:wSelf.scanCallBack(wSelf.peripherals);
    }];
    
   [_bluetooth setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
       if (peripheralName.length >0) {
           return YES;
       }
       return NO;
//        switch (wSelf.filterType) {
//            case YDBlueToothFilterTypeMatch:
//            {
//                if ([peripheralName isEqualToString:wSelf.matchField]) {
//                    return YES;
//                }
//                return NO;
//            }
//                break;
//            case YDBlueToothFilterTypeContain:
//            {
//                if ([peripheralName containsString:wSelf.containField]) {
//                    return YES;
//                }
//                return NO;
//            }
//                break;
//            case YDBlueToothFilterTypePrefix:
//            {
//                if ([peripheralName hasPrefix:wSelf.prefixField]) {
//                    return YES;
//                }
//                return NO;
//            }
//                break;
//            case YDBlueToothFilterTypeSuffix:
//            {
//                if ([peripheralName hasSuffix:wSelf.suffixField]) {
//                    return YES;
//                }
//                return NO;
//            }
//                break;
//            case YDBlueToothFilterTypePrefixAndContain:
//            {
//                if ([peripheralName hasPrefix:wSelf.prefixField] && [peripheralName containsString:wSelf.containField]) {
//                    return YES;
//                }
//                return NO;
//            }
//                break;
//            case YDBlueToothFilterTypePrefixAndSuffix:
//            {
//                if ([peripheralName hasPrefix:wSelf.prefixField] && [peripheralName hasSuffix:wSelf.suffixField]) {
//                    return YES;
//                }
//                return NO;
//            }
//                break;
//            case YDBlueToothFilterTypeSuffixAndContrain:
//            {
//                if ([peripheralName hasSuffix:wSelf.suffixField] && [peripheralName containsString:wSelf.containField]) {
//                    return YES;
//                }
//                return NO;
//            }
//                break;
//            case YDBlueToothFilterTypePrefixAndContrainAndSuffix:
//            {
//                if ([peripheralName hasPrefix:wSelf.prefixField] && [peripheralName containsString:wSelf.containField] && [peripheralName hasSuffix:wSelf.suffixField]) {
//                    return YES;
//                }
//                return NO;
//            }
//                break;
//            default:
//                return NO;
//                break;
//        }
//        return NO;
    }];
    
#pragma mark - connect & services
    [_bluetooth setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        NSLog(@"setBlockOnConnected");
    }];
    
    [_bluetooth setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"setBlockOnFailToConnect");
    }];
    
    [_bluetooth setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"setBlockOnDisconnect");
    }];
    
    [_bluetooth setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        NSLog(@"setBlockOnDiscoverServices");
        [wSelf addConnectedServicesWithServices:peripheral.services];
        !wSelf.servicesCallBack?:wSelf.servicesCallBack(wSelf.connectedPeripheralServices);
        [rhythm beats];
    }];
    
    [rhythm setBlockOnBeatsBreak:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsBreak call");
    }];
    
    //设置beats over委托
    [rhythm setBlockOnBeatsOver:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsOver call");
    }];

#pragma mark - services & characteristic
    
    [_bluetooth setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"setBlockOnDiscoverCharacteristics");
    }];
    
    [_bluetooth setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"setBlockOnReadValueForCharacteristic");
    }];
    
// characteristic & discriptors
    [_bluetooth setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"setBlockOnDiscoverDescriptorsForCharacteristic");
    }];
    
    [_bluetooth setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"setBlockOnReadValueForDescriptors");
    }];
    
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnNotificationKey:@YES};
    
//    [_bluetooth setBabyOptionsAtChannel:connectionChannel scanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    [_bluetooth setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];

}

#pragma mark -- custom methods

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (void)initWithFilterField:(NSString *)filterField withFilterType:(YDBlueToothFilterType) type {
    switch (type) {
        case YDBlueToothFilterTypeMatch:
            break;
        case YDBlueToothFilterTypeContain:
            break;
        default:
            break;
    }
}

- (void)startScan {
    
    _peripherals = [NSMutableArray<CBPeripheral *> new];
    [_bluetooth cancelAllPeripheralsConnection];
    _bluetooth = [BabyBluetooth shareBabyBluetooth];
    
    [self babyDelegate];
    _bluetooth.scanForPeripherals().begin();
}

- (void)quitConnected {
    if (_currentPeripheral) {
        [_bluetooth cancelPeripheralConnection:_currentPeripheral];
        _currentPeripheral = nil;
    }
}

- (void)addConnectedServicesWithServices:(NSArray<CBService *> *)services {
    for (CBService *service in services) {
        [self addConnectedServicesWithService:service];
    }
}

- (void)addConnectedServicesWithService:(CBService *)service {
    [_connectedPeripheralServices addObject:service];
}

// custom action method
- (void)onConnectBluetoothWithIndex:(NSInteger)index {
    [self onConnectBluetoothWithPeripheral:_peripherals[index]];
}

- (void)onConnectBluetoothWithPeripheral:(CBPeripheral *)peripheral {
    [self _onConnectPrepareWithWillConnectingPeripheral:peripheral];
    _bluetooth.having(peripheral).connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

- (void)_onConnectPrepareWithWillConnectingPeripheral:(CBPeripheral *)peripheral {
    _currentPeripheral = peripheral;
    [_bluetooth cancelScan];
    [SVProgressHUD showInfoWithStatus:@"开始连接设备"];
    _connectedPeripheralServices = [NSMutableArray<CBService *> new];
}

- (void)onConnectCurrentPeripheralOfBluetooth {
    [self onConnectBluetoothWithPeripheral:_currentPeripheral];
}

#pragma mark -- some block methods

- (YDBlueToothMgr * (^)(NSInteger index))connectingPeripheralIndex {
    __weak typeof (self) wSelf = self;
    return ^(NSInteger index) {
        wSelf.currentIndex = index;
        wSelf.currentPeripheral = wSelf.peripherals[index];
        return self;
    };
}

- (YDBlueToothMgr * (^)(CBPeripheral *peripheral))connectedPeripheral {
    __weak typeof (self) wSelf = self;
    return ^(CBPeripheral *peripheral){
        wSelf.currentPeripheral = peripheral;
        return self;
    };
}


@end
