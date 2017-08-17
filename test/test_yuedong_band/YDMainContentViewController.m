//
//  YDMainContentViewController.m
//  test_yuedong_band
//
//  Created by Aka on 2017/8/17.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDMainContentViewController.h"
#import "YDSettingViewController.h"
#import "YDBluetoothWebViewMgr+ReadDatas.h"
#import "YDBluetoothWebViewMgr+WriteDatas.h"

@interface YDMainContentViewController ()

@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *calorieLabel;

@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIButton *batteryBtn;
@property (nonatomic, strong) UIButton *syncBtn;

@property (nonatomic, strong) NSArray *services;

@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;
@property (nonatomic, strong) CBCharacteristic *readCharacteristic;

@property (nonatomic, strong) NSMutableArray *nCharacteristics;

@property (nonatomic, strong) NSMutableArray *needWriteDatas;
@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, assign) BOOL isNeedWriteDatasAtInitConnected;

@end

@implementation YDMainContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _nCharacteristics = @[].mutableCopy;
    _needWriteDatas = @[].mutableCopy;
    
    _stepLabel = [UILabel new];
    _stepLabel.frame = CGRectMake(0, 100, 100, 30);
    _stepLabel.text = @"步数";
    [self.view addSubview:_stepLabel];

    _distanceLabel = [UILabel new];
    _distanceLabel.frame = CGRectMake(120, 100, 100, 30);
    _distanceLabel.text = @"距离";
    [self.view addSubview:_distanceLabel];

    _calorieLabel = [UILabel new];
    _calorieLabel.frame = CGRectMake(240, 100, 100, 30);
    _calorieLabel.text = @"卡路里";
    [self.view addSubview:_calorieLabel];
    

    _settingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(onSettinClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_settingBtn];
    _settingBtn.frame = CGRectMake(0, 200, 100, 40);

    _batteryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_batteryBtn setTitle:@"电池" forState:UIControlStateNormal];
    [_batteryBtn addTarget:self action:@selector(onBatteryClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_batteryBtn];
    _batteryBtn.frame = CGRectMake(120, 200, 100, 40);
    
    _syncBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_syncBtn setTitle:@"同步" forState:UIControlStateNormal];
    [_syncBtn addTarget:self action:@selector(onSyncClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_syncBtn];
    _syncBtn.frame = CGRectMake(230, 200, 200, 40);
    
    [self backDatasFromBlock];
    [self __addNotify];
}

- (void)__addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStepAndDistanceClick:) name:@"stepAndDsitance" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEnergyClick:) name:@"energyData" object:nil];
}

- (void)onStepAndDistanceClick:(NSNotification *)noti {
    NSDictionary *dic = (NSDictionary *)noti.object;
    _stepLabel.text = [NSString stringWithFormat:@"步数：%@",[dic objectForKey:@"step"]];
    _calorieLabel.text = [NSString stringWithFormat:@"卡路里：%@",[dic objectForKey:@"calorie"]];
    _distanceLabel.text =  [NSString stringWithFormat:@"距离：%@",[dic objectForKey:@"distance"]];
}

- (void)onEnergyClick:(NSNotification *)noti {
    NSDictionary *dic = (NSDictionary *)noti.object;
    float energe = [dic[@"energy"] integerValue] *12.5;
    NSString *batteryText = [NSString stringWithFormat:@"电量: %%%.1f",energe] ;
    [_batteryBtn setTitle:batteryText forState:UIControlStateNormal];
}

- (void)backDatasFromBlock {
    __weak typeof (self) wSelf = self;
    _mgr.servicesCallBack = ^(NSArray<CBService *> *services) {
        wSelf.services = services;
        for (CBService *service in services) {
            NSLog(@"vc service : %@",service);
//            [wSelf.choicePeripheral discoverServices:service];
        }
    };
    
    _mgr.discoverCharacteristicCallback = ^(CBCharacteristic *c) {
        NSLog(@" vc discover characteristic : %@",c);
        if ([c.UUID.UUIDString isEqualToString:@"FFF6"]) {
            wSelf.writeCharacteristic = c;
            wSelf.mgr.writeCharacteristic = c;
            if (wSelf.isConnected && wSelf.isNeedWriteDatasAtInitConnected) {
                [wSelf __writeDatsAtInitConnected];
                wSelf.isNeedWriteDatasAtInitConnected = NO;
            }
        }
        
        if ([c.UUID.UUIDString isEqualToString:@"FFF7"]) {
            wSelf.readCharacteristic = c;
            [wSelf.mgr setNotifyWithPeripheral:wSelf.choicePeripheral characteristic:c block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
                [wSelf.mgr readByteWithData:characteristics.value];
            }];
        }
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFA1"]]) {
            [wSelf.choicePeripheral readRSSI];
        }
        [wSelf.nCharacteristics addObject:c];
    };
    
    _mgr.updateValueCharacteristicCallBack = ^(CBCharacteristic *c) {
        NSLog(@" vc update vlaue : %@",c);
    };
    
    [_mgr onConnectPeripheral:_choicePeripheral then:^(NSArray<CBService *> *services) {
        for (CBService *service in services) {
            NSLog(@" vc service : %@",service);
        }
    }];
    
    _mgr.connectionCallBack = ^(BOOL success) {
        if (success) {
            NSLog(@"vc success : %d",success);
            wSelf.isConnected = YES;
            wSelf.isNeedWriteDatasAtInitConnected = YES;
        }
    };
    
}

- (void)__writeDatsAtInitConnected {
        [NSTimer scheduledTimerWithTimeInterval:0.7f target:_mgr selector:@selector(connectAlert) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:_mgr selector:@selector(setSystemTime) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:1.3f target:_mgr selector:@selector(startRealtimeStep) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:1.6f target:_mgr selector:@selector(readMacAddress) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:1.9f target:_mgr selector:@selector(writeStepTarget) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:2.2f target:_mgr selector:@selector(bandSync) userInfo:nil repeats:NO];
}

- (void)onSettinClick {
    YDSettingViewController *vc = [YDSettingViewController new];
    vc.webViewMgr = _mgr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onBatteryClick {
    [_mgr readDeviceEnergy];
}

- (void)onSyncClick {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
