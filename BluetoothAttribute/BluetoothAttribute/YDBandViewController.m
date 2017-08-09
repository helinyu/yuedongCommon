//
//  YDBandViewController.m
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/9.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDBandViewController.h"
#import "YDBluetoothMgr.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface YDBandViewController ()

@property (nonatomic, strong) YDBluetoothMgr *btMgr;
@property (nonatomic, strong) CBPeripheral *selectedPeripheral;


@end

@implementation YDBandViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self UICreation];
    _btMgr = YDBluetoothMgr.shared();
    _selectedPeripheral = _btMgr.selectedPeripheral;
    [self datasFromBlueToothCallback];
}

- (void)datasFromBlueToothCallback {
    __weak typeof (self) wSelf = self;
    _btMgr.discoverServices(nil).servicesBlock = ^(CBServices services) {
//        这里处理services
        [services enumerateObjectsUsingBlock:^(CBService * _Nonnull service, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([service.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF0"]]) {
//
//                read : app write to the peripheral
                wSelf.btMgr.discoverCharacteristic(nil,service).characteristicCallback = ^(CBCharacteristic *characteristic) {
//                    deal with characteristic
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF1"]]) {
                        [_selectedPeripheral writeValue:nil forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                    }
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF2"]]) {
                        [_selectedPeripheral setNotifyValue:YES forCharacteristic:characteristic];
                    }
                };
            }
//            if ([service.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF1"]]) {
//                write
//            }
//            if ([service.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF2"]]) {
//                notifiry
//            }
        }];
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- custom methods
- (void)UICreation {
    UILabel *todayLabel = [UILabel new];
    [self.view addSubview:todayLabel];
    todayLabel.text = @"今天";
    todayLabel.frame = CGRectMake(100, 60, 100, 30);
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [self.view addSubview:stepLabel];
    stepLabel.text = @"0";
    
//    right setting button
    UIBarButtonItem *settingBarItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingClicked)];
    UIBarButtonItem *powerBarItem = [[UIBarButtonItem alloc] initWithTitle:@"电量" style:UIBarButtonItemStylePlain target:self action:@selector(onPowerClicked)];
    UIBarButtonItem *synBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"立即同步" style:UIBarButtonItemStylePlain target:self action:@selector(onSynClicked)];
    self.navigationController.navigationBar.topItem.rightBarButtonItems = @[settingBarItem,powerBarItem,synBtnItem];
    
//    distance
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 140, 100, 30)];
    [self.view addSubview:distanceLabel];
    distanceLabel.text = @"0";
    
//DA KA
    UILabel *calorieLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 100, 30)];
    [self.view addSubview:calorieLabel];
    calorieLabel.text = @"0";
    
//    sleep
    UILabel *sleepLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 100, 30)];
    [self.view addSubview:sleepLabel];
    sleepLabel.text = @"0";
    
//    heart rate
    UILabel *heartRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 100, 30)];
    [self.view addSubview:heartRateLabel];
    heartRateLabel.text = @"0";

}

- (void)onSettingClicked {
    NSLog(@"设置的有关内容");
}

- (void)onPowerClicked {
    NSLog(@"电量的设置");
}

- (void)onSynClicked {
    NSLog(@"同步");
}

@end
