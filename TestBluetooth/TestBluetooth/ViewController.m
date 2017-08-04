//
//  ViewController.m
//  TestBluetooth
//
//  Created by Aka on 2017/8/4.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *cMgr;

@property (nonatomic, strong) NSMutableArray *peripherals;

@property (nonatomic, strong) CBPeripheral *currentPeripheral;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cMgr = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    _peripherals  = [NSMutableArray new];
    
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
        [_cMgr scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"peripheral : %@",peripheral);
    if ([peripheral.name isEqualToString:@"SHH"]) {
        [_cMgr stopScan];
        [_cMgr connectPeripheral:peripheral options:nil];
        if (_peripherals.count > 0) {
            BOOL flag = NO;
            for (CBPeripheral *item in _peripherals) {
                if ([item.identifier isEqual:item.name]) {
                    flag = YES;
                    break;
                }
            }
            if (!flag) {
                _currentPeripheral = peripheral;
                [_peripherals addObject:peripheral];
            }
        }else{
            _currentPeripheral = peripheral;
            [_peripherals addObject:peripheral];
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"peripheral connected: %@",peripheral);
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"链接失败： %@",error);
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"didDisconnectPeripheral : %@",error);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"service : %@",peripheral.services);
    
    for (CBService *serviceItem in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:serviceItem];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"didDiscoverCharacteristicsForService");
    for (CBCharacteristic *cItem  in service.characteristics) {
        NSLog(@"cItem : %@",cItem);
    }
    
    [_cMgr connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,CBConnectPeripheralOptionNotifyOnNotificationKey:@YES}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
