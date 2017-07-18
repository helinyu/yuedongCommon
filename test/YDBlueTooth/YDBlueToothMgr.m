//
//  YDBlueToothMgr.m
//  test
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDBlueToothMgr.h"
#import "BabyBluetooth.h"

@interface YDBlueToothMgr ()

@property (nonatomic, strong) BabyBluetooth *bluetooth;

//@property (nonatomic, strong, readwrite) NSMutableArray<CBPeripheral *> *peripherals;

@end

static NSString *const connectionChannel = @"connection.channel";


@implementation YDBlueToothMgr

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

#pragma mark -- all delegate block

- (void)babyDelegate {
    
    __weak typeof  (self) wSelf = self;
    [_bluetooth setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBManagerStatePoweredOn) {
//            [SVProgressHUD showInfoWithStatus:@"设备打开成功，开始扫描设备"];
            NSLog(@"设备打开成功，开始扫描蓝牙设备");
        }
    }];
    
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
        }
    }];
    
   [_bluetooth setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        switch (wSelf.filterType) {
            case YDBlueToothFilterTypeMatch:
            {
                if ([peripheralName isEqualToString:wSelf.matchField]) {
                    return YES;
                }
                return NO;
            }
                break;
            case YDBlueToothFilterTypeContain:
            {
                if ([peripheralName containsString:wSelf.containField]) {
                    return YES;
                }
                return NO;
            }
                break;
            case YDBlueToothFilterTypePrefix:
            {
                if ([peripheralName hasPrefix:wSelf.prefixField]) {
                    return YES;
                }
                return NO;
            }
                break;
            case YDBlueToothFilterTypeSuffix:
            {
                if ([peripheralName hasSuffix:wSelf.suffixField]) {
                    return YES;
                }
                return NO;
            }
                break;
            case YDBlueToothFilterTypePrefixAndContain:
            {
                if ([peripheralName hasPrefix:wSelf.prefixField] && [peripheralName containsString:wSelf.containField]) {
                    return YES;
                }
                return NO;
            }
                break;
            case YDBlueToothFilterTypePrefixAndSuffix:
            {
                if ([peripheralName hasPrefix:wSelf.prefixField] && [peripheralName hasSuffix:wSelf.suffixField]) {
                    return YES;
                }
                return NO;
            }
                break;
            case YDBlueToothFilterTypeSuffixAndContrain:
            {
                if ([peripheralName hasSuffix:wSelf.suffixField] && [peripheralName containsString:wSelf.containField]) {
                    return YES;
                }
                return NO;
            }
                break;
            case YDBlueToothFilterTypePrefixAndContrainAndSuffix:
            {
                if ([peripheralName hasPrefix:wSelf.prefixField] && [peripheralName containsString:wSelf.containField] && [peripheralName hasSuffix:wSelf.suffixField]) {
                    return YES;
                }
                return NO;
            }
                break;
            default:
                return NO;
                break;
        }
        return NO;
    }];
    
//connetc
    [_bluetooth setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        
    }];
    
    [_bluetooth setBlockOnConnectedAtChannel:connectionChannel block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        
    }];

    [_bluetooth setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        
    }];
    
    [_bluetooth setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        
    }];
    
//    discover
    [_bluetooth setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        
    }];
    
    [_bluetooth setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"setBlockOnDiscoverCharacteristics");
    }];
    
//    [_bluetooth setBlockOnDiscoverToPeripheralsAtChannel:connectionChannel block:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
//        NSLog(@"setBlockOnDiscoverToPeripheralsAtChannel");
//    }];

}

// custom action method
- (void)onConnectBluetoothWithIndex:(NSInteger)index {
    [_bluetooth cancelScan];
    CBPeripheral *peripheral = _peripherals[index];
//    _bluetooth.connectToPeripherals().begin();  // 不设置channel，默认值吧
    _bluetooth.having(peripheral).then.connectToPeripherals().and.discoverServices().and.discoverCharacteristics().then.readValueForCharacteristic().and.discoverDescriptorsForCharacteristic().then.readValueForDescriptors().then.begin();
}


@end
