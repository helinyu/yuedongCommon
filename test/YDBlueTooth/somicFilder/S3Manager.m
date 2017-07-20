//
//  S3Manager.m
//  YDOpenHardwareThirdPart
//
//  Created by mac-somic on 2017/4/25.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "S3Manager.h"
#import "YDOpenHardwareManager.h"
#import "YDOpenHardwareDataProvider.h"
#import "YDOpenHardwareIntelligentScale.h"
#import "YDOpenHardwareHeartRate.h"
#import "YDOpenHardwareSDK.h"

@interface S3Manager ()
{
    int _lastStepNUm;//上一次同步到悦动圈的步数
    int _step;
    int  _calorie;
    float _disM;
    BOOL _isFirstReload;
}

@property (strong, nonatomic, readwrite) NSMutableArray *nDevices;

@end

@implementation S3Manager

+ (instancetype)shareManager{
    
    static S3Manager *_S3Maneger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _S3Maneger = [[S3Manager alloc]init];
        
    });
    return _S3Maneger;
}

- (instancetype)init{
    self = [super init];
    
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    YDOpenHardwareUser *YDUser = [[YDOpenHardwareManager sharedManager] getCurrentUser];
    self.user_id = [NSString stringWithFormat:@"%@",YDUser.userID];
    
    [self addNotify];
    _nDevices = [[NSMutableArray alloc]init];
    return self;
}

- (void)addNotify{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YDNtfOpenHardwareUserChange:) name:YDNtfOpenHardwareUserChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppdidFinishLaunch:) name:YDNtfOpenHardwareAppdidFinishLaunch object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppWillResignActive:) name:YDNtfOpenHardwareAppWillResignActive object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppDidEnterBackground:) name:YDNtfOpenHardwareAppDidEnterBackground object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppWillEnterForeground:) name:YDNtfOpenHardwareAppWillEnterForeground object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppDidBecomeActive:) name:YDNtfOpenHardwareAppDidBecomeActive object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppWillTerminate:) name:YDNtfOpenHardwareAppWillTerminate object:nil];
    
}

#pragma mark -- 蓝牙的代理方法 --

/**
 开始查看服务，蓝牙开启
 */
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
        {
            [self.manager scanForPeripheralsWithServices:nil  options:nil];
        }
            break;
        case CBCentralManagerStatePoweredOff:
            break;
        default:
            break;
    }
}

- (void)scanForPeripherals{
    [self.manager scanForPeripheralsWithServices:nil  options:nil];
    NSLog(@"scanForPeripherals");
}

- (void)connectS3Bluetooth{
    [self.manager connectPeripheral:self.peripheral options:nil];
}

/**
 搜索正在广告的外围设备
 */
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{

    if (![peripheral.name isEqualToString:@"S3"]) {
        return;
    }
    
    if (self.nDevices.count <= 0) {
        [_nDevices addObject:peripheral];
        return;
    }
    
    BOOL isDuplicate = NO;
    for (NSInteger i=0; i < _nDevices.count; i++) {
        CBPeripheral *p = [_nDevices objectAtIndex:i];
        if ([p isEqual:peripheral]) {
            isDuplicate = YES;
            break;
        }
    }
    
    if (!isDuplicate) {
        [_nDevices addObject:peripheral];
    }
    
    return;
}

/**
 连接外设成功，开始发现服务
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
    
    _deviceId = [NSString stringWithFormat:@"%@",peripheral.identifier];
    _plugName = [NSString stringWithFormat:@"%@",peripheral.name];
    //是否注册
    [[YDOpenHardwareManager sharedManager] isRegistered: _deviceId plug: _plugName user: @([_user_id integerValue]) block:^(YDOpenHardwareOperateState operateState, NSString *deviceIdentity) {
        BOOL flag = operateState == YDOpenHardwareOperateStateHasRegistered;
        NSString *msg = @"";
        if (flag) {
            msg = @"已经注册";
            self.device_identify = deviceIdentity;
        } else {
            msg = @"没有注册";
            //绑定硬件设备后需要向悦动圈注册设备
            [[YDOpenHardwareManager sharedManager] registerDevice: _deviceId plug: _plugName user: @([_user_id integerValue]) block:^(YDOpenHardwareOperateState operateState, NSString *deviceIdentity, NSNumber *userId) {
                if (operateState == 0) {
                    self.device_identify = deviceIdentity;
                }
                
            }];
        }
    }];
    
}

/**
 连接外设失败
 */
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
}

-(void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
    
    int rssi = abs([RSSI intValue]);
}

/**
 搜索你已经连接的外围设备的服务
 */
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    int i=0;
    for (CBService *s in peripheral.services) {
        i++;
        [peripheral discoverCharacteristics:nil forService:s];
        
        if ([s.UUID isEqual:[CBUUID UUIDWithString:@"FFF0"]]) {
            BOOL replace = NO;
            for (int i=0; i < _nDevices.count; i++) {
                CBPeripheral *p = [_nDevices objectAtIndex:i];
                if ([p isEqual:peripheral]) {
                    [_nDevices replaceObjectAtIndex:i withObject:peripheral];
                    replace = YES;
                }
            }
            if (!replace) {
                [_nDevices addObject:peripheral];
            }
        }
    }
}

/**
 //步骤五.搜索服务的特征   Characteristics
 */
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for (CBCharacteristic *c in service.characteristics) {
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]) {
            _writeCharacteristic = c;
        }
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
            NSLog(@"ff2 didDiscoverCharacteristicsForService :readValueForCharacteristic");
            [self.peripheral readValueForCharacteristic:c];//读取
            NSLog(@"ff2 didDiscoverCharacteristicsForService :setNotifyValue");
            [self.peripheral setNotifyValue:YES forCharacteristic:c];//订阅
        }
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF3"]]) {
            NSLog(@" ff3 didDiscoverCharacteristicsForService :readValueForCharacteristic");
            [self.peripheral readValueForCharacteristic:c];
            NSLog(@" ff3 didDiscoverCharacteristicsForService :setNotifyValue");
            [self.peripheral setNotifyValue:YES forCharacteristic:c];
        }
    }
}

/**
 解绑蓝牙设备
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
    // 失去和外围设备连接后重建连接
    if ([self.peripheral.name isEqualToString:@"S3"]) {
        [self.manager connectPeripheral:self.peripheral options:nil];
    }
}

/**
 直接读取特征的值
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didUpdateValueForCharacteristic: error: %@",error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"S3ManagerDidUpdataValueForCharacteristic" object:characteristic];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self insertDataToYDOpen:characteristic];
    });
}

- (void)insertDataToYDOpen:(CBCharacteristic *)characteristic{
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
        NSData * data = characteristic.value;
        Byte * resultByte = (Byte *)[data bytes];
        
        for(int i=0;i<[data length];i++){
            if (i == 2) {
                
                int heartNUM = resultByte[i];
                NSString *heatString = [NSString stringWithFormat:@"%d",heartNUM];
                
                if (heartNUM == 0) {
                    return;
                }
                
                
                NSDate * now = [self currentTime:[NSDate date]];
                YDOpenHardwareHeartRate *hr = [[YDOpenHardwareHeartRate alloc] init];
                [hr constructByOhhId: nil DeviceId: _device_identify HeartRate: @([heatString integerValue]) StartTime: now EndTime: now UserId: @([_user_id integerValue]) Extra: @"" ServerId:nil Status:nil];
                //插入心率新记录,插入成功后会自动更新传入数据的主键
                [[YDOpenHardwareManager dataProvider] insertHeartRate: hr completion:^(BOOL success) {
                    
                }];
                
                //建立OpenHardwarePedometer
                YDOpenHardwarePedometer *pedomenter = [[YDOpenHardwarePedometer alloc]init];
                
                NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
                NSString *stepStr = [defaluts objectForKey:@"lastInsertStepsS3"];
                
                _lastStepNUm = stepStr.intValue;
                
                
                if (_step == 0 || _lastStepNUm == _step) {
                    return;
                }
                if ((_lastStepNUm > _step)|| (_isFirstReload == YES)) {
                    _lastStepNUm = 0;
                }
                
                [pedomenter constructByOhpId:nil DeviceId:_device_identify NumberOfStep:[NSNumber numberWithInt:(_step-_lastStepNUm)] Distance:[NSNumber numberWithFloat:_disM] Calorie:[NSNumber numberWithInt:_calorie] StartTime:now EndTime:now UserId:@([_user_id integerValue]) Extra:@"" ServerId:nil Status:nil];
                
                //插入计步数据
                [[YDOpenHardwareManager dataProvider] insertPedometer:pedomenter completion:^(BOOL success) {
                    
                    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
                    [defalut setObject:[NSString stringWithFormat:@"%d",_step] forKey:@"lastInsertStepsS3"];
                    _isFirstReload = NO;
                }];
            }
        }
    }else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF3"]]) {
        //步数
        NSData * data = characteristic.value;
        Byte * resultByte = (Byte *)[data bytes];
        
        for(int i=0;i<[data length];i++){
            int a = resultByte[3];
            _step = resultByte[2];
            if (a !=0) {
                _step = resultByte[2] + 256*a;
            }
            if (i == 2) {
                //                //卡路里
                _calorie = (int) (_step * 0.5 / 14);
                //                //距离
                _disM = (float)(_step * 0.5 / 1000);
                
            }
        }
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]){
        
    }
}

/**
 订阅一个特征的值
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
    }
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
        NSLog(@"didUpdateNotificationStateForCharacteristic :readValueForCharacteristic");
    } else {
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}

///**
// //用于检测中心向外设写数据是否成功
// */
//-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//{
//    if (error) {
//    }else{
//
//    }
//
//    [peripheral readValueForCharacteristic:characteristic];
//    NSLog(@"didWriteValueForCharacteristic:readValueForCharacteristic");
//}

/**
 获取当前时区的当前时间
 */
- (NSDate *)currentTime:(NSDate *)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    date = [date dateByAddingTimeInterval:interval];
    return date;
}


#pragma mark -- 检测通知变化的回调操作 --
- (void)YDNtfOpenHardwareUserChange:(NSNotification *)notification{
    
    //向悦动圈解绑设备
    [[YDOpenHardwareManager sharedManager] unRegisterDevice: [S3Manager shareManager].device_identify plug: [S3Manager shareManager].plugName user: @([[S3Manager shareManager].user_id integerValue]) block:^(YDOpenHardwareOperateState operateState) {
        
    }];
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
    [defaluts removeObjectForKey:@"lastInsertStepsS3"];
}

- (void)AppdidFinishLaunch:(NSNotification *)notification{
    
}
- (void) AppWillResignActive:(NSNotification *)notification{
}
- (void) AppDidEnterBackground:(NSNotification *)notification{
}
- (void) AppWillEnterForeground:(NSNotification *)notification{
}
- (void) AppDidBecomeActive:(NSNotification *)notification{
}
- (void) AppWillTerminate:(NSNotification *)notification{
}


@end
