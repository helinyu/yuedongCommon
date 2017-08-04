//
//  S3Manager.m
//  YDOpenHardwareThirdPart
//
//  Created by mac-somic on 2017/4/25.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "ANCSBleManager.h"
#import "YDOpenHardwareManager.h"
#import "YDOpenHardwareDataProvider.h"
#import "YDOpenHardwareIntelligentScale.h"
#import "YDOpenHardwareHeartRate.h"
#import "YDOpenHardwareSDK.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ANCSBleManager ()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    int _lastStepNUm;//上一次同步到悦动圈的步数
    int _step;
    int  _calorie;
    float _disM;
    BOOL _isFirstReload;
}

@property (strong, nonatomic, readwrite) NSMutableArray *nDevices;

@end

@implementation ANCSBleManager

+ (instancetype)shareManager{
    
    static ANCSBleManager *_S3Maneger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _S3Maneger = [[ANCSBleManager alloc]init];
        
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
}

#pragma mark -- 蓝牙的代理方法 --



- (void)scanForPeripherals{
    [self.manager scanForPeripheralsWithServices:nil  options:nil];
    NSLog(@"scanForPeripherals");
}

- (void)connectS3Bluetooth{
    [self.manager stopScan];
    [self.manager connectPeripheral:self.peripheral options:nil];
}

#pragma mark -- 检测通知变化的回调操作 --
- (void)YDNtfOpenHardwareUserChange:(NSNotification *)notification{
    
    //向悦动圈解绑设备
    [[YDOpenHardwareManager sharedManager] unRegisterDevice: [ANCSBleManager shareManager].device_identify plug: [ANCSBleManager shareManager].plugName user: @([[ANCSBleManager shareManager].user_id integerValue]) block:^(YDOpenHardwareOperateState operateState) {
        
    }];
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
    [defaluts removeObjectForKey:@"lastInsertStepsS3"];
}


#pragma mark -- CBPeripheralDelegate

- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral NS_AVAILABLE(NA, 6_0) {
    NSLog(@"peripheralDidUpdateName");
}

/*!
 *  @method peripheral:didModifyServices:
 *
 *  @param peripheral			The peripheral providing this update.
 *  @param invalidatedServices	The services that have been invalidated
 *
 *  @discussion			This method is invoked when the @link services @/link of <i>peripheral</i> have been changed.
 *						At this point, the designated <code>CBService</code> objects have been invalidated.
 *						Services can be re-discovered via @link discoverServices: @/link.
 */
- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices NS_AVAILABLE(NA, 7_0) {
    NSLog(@"didModifyServices");
}

/*!
 *  @method peripheralDidUpdateRSSI:error:
 *
 *  @param peripheral	The peripheral providing this update.
 *	@param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link readRSSI: @/link call.
 *
 *  @deprecated			Use {@link peripheral:didReadRSSI:error:} instead.
 */
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(nullable NSError *)error NS_DEPRECATED(NA, NA, 5_0, 8_0) {
    NSLog(@"peripheralDidUpdateRSSI");
}

/*!
 *  @method peripheral:didReadRSSI:error:
 *
 *  @param peripheral	The peripheral providing this update.
 *  @param RSSI			The current RSSI of the link.
 *  @param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link readRSSI: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(nullable NSError *)error NS_AVAILABLE(NA, 8_0) {
    int rssi = abs([RSSI intValue]);
}

-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    _manager.isScanning?[_manager stopScan ]:nil;
    
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


- (NSDate *)currentTime:(NSDate *)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    date = [date dateByAddingTimeInterval:interval];
    return date;
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


/*!
 *  @method peripheral:didDiscoverIncludedServicesForService:error:
 *
 *  @param peripheral	The peripheral providing this information.
 *  @param service		The <code>CBService</code> object containing the included services.
 *	@param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link discoverIncludedServices:forService: @/link call. If the included service(s) were read successfully,
 *						they can be retrieved via <i>service</i>'s <code>includedServices</code> property.
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"didDiscoverIncludedServicesForService");
}

/*!
 *  @method peripheral:didDiscoverCharacteristicsForService:error:
 *
 *  @param peripheral	The peripheral providing this information.
 *  @param service		The <code>CBService</code> object containing the characteristic(s).
 *	@param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link discoverCharacteristics:forService: @/link call. If the characteristic(s) were read successfully,
 *						they can be retrieved via <i>service</i>'s <code>characteristics</code> property.
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"didDiscoverCharacteristicsForService uuid : %@",service.UUID);
    for (CBCharacteristic *c in service.characteristics) {
//        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]) {
//            _writeCharacteristic = c;
//        }
//        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
        NSLog(@"charateristic uudi : %@",c.UUID);
            [self.peripheral readValueForCharacteristic:c];//读取
            [self.peripheral setNotifyValue:YES forCharacteristic:c];//订阅
//        }
//        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF3"]]) {
//            NSLog(@" ff3 didDiscoverCharacteristicsForService :readValueForCharacteristic");
//            [self.peripheral readValueForCharacteristic:c];
//            NSLog(@" ff3 didDiscoverCharacteristicsForService :setNotifyValue");
//            [self.peripheral setNotifyValue:YES forCharacteristic:c];
//        }
    }

//    for (CBCharacteristic *c in service.characteristics) {
//        switch (c.properties) {
//            case CBCharacteristicPropertyBroadcast:
//                NSLog(@"broadcast 需要怎么样精心处理？");
//                break;
//            case CBCharacteristicPropertyRead:
//                [self.peripheral readValueForCharacteristic:c];
//                break;
//            case CBCharacteristicPropertyNotify:
//                [self.peripheral setNotifyValue:YES forCharacteristic:c];
//                break;
//            case CBCharacteristicPropertyWriteWithoutResponse:
//                NSLog(@"写不需要返回响应");
//                break;
//            case CBCharacteristicPropertyWrite:
//                NSLog(@"write charateristic");
//                break;
//            case CBCharacteristicPropertyIndicate:
//                NSLog(@"Indicate 这个不知道要干嘛，应该是和ANCS有关，猜的");
//                break;
//            case CBCharacteristicPropertyAuthenticatedSignedWrites:
//                NSLog(@"签名认证 写");
//                break;
//            case CBCharacteristicPropertyExtendedProperties:
//                NSLog(@"");
//                break;
//            case CBCharacteristicPropertyNotifyEncryptionRequired:
//                NSLog(@"要求加密,通知加密");
//                break;
//            case CBCharacteristicPropertyIndicateEncryptionRequired:
//                NSLog(@"表明加密");
//                break;
//            default:
//                break;
//        }
//    }
}

/*!
 *  @method peripheral:didUpdateValueForCharacteristic:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param characteristic	A <code>CBCharacteristic</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method is invoked after a @link readValueForCharacteristic: @/link call, or upon receipt of a notification/indication.
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"S3ManagerDidUpdataValueForCharacteristic" object:characteristic];

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self insertDataToYDOpen:characteristic];
//    });

//    NSLog(@"characteristic 内容开始读取： %@",characteristic.service.UUID.UUIDString);
    NSData * data = characteristic.value;
    Byte * resultByte = (Byte *)[data bytes];
    NSLog(@"charateristic uuid : %@",characteristic.UUID);
    for(int i=0;i<[data length];i++){
        NSLog(@"%hhu",resultByte[i]);
    }
}

/*!
 *  @method peripheral:didWriteValueForCharacteristic:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param characteristic	A <code>CBCharacteristic</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a {@link writeValue:forCharacteristic:type:} call, when the <code>CBCharacteristicWriteWithResponse</code> type is used.
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"didWriteValueForCharacteristic : %@",characteristic.UUID.UUIDString);
}

/*!
 *  @method peripheral:didUpdateNotificationStateForCharacteristic:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param characteristic	A <code>CBCharacteristic</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a @link setNotifyValue:forCharacteristic: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error) {
    }
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else {
        [self.manager cancelPeripheralConnection:self.peripheral];
    }

}

/*!
 *  @method peripheral:didDiscoverDescriptorsForCharacteristic:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param characteristic	A <code>CBCharacteristic</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a @link discoverDescriptorsForCharacteristic: @/link call. If the descriptors were read successfully,
 *							they can be retrieved via <i>characteristic</i>'s <code>descriptors</code> property.
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}
/*!
 *  @method peripheral:didUpdateValueForDescriptor:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param descriptor		A <code>CBDescriptor</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a @link readValueForDescriptor: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    
}

/*!
 *  @method peripheral:didWriteValueForDescriptor:error:
 *
 *  @param peripheral		The peripheral providing this information.
 *  @param descriptor		A <code>CBDescriptor</code> object.
 *	@param error			If an error occurred, the cause of the failure.
 *
 *  @discussion				This method returns the result of a @link writeValue:forDescriptor: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    
}

#pragma mark -- CBCentralManagerDelegate [主要是搜索和链接设备]
/*!
 *  @method centralManagerDidUpdateState:
 *
 *  @param central  The central manager whose state has changed.
 *
 *  @discussion     Invoked whenever the central manager's state has been updated. Commands should only be issued when the state is
 *                  <code>CBCentralManagerStatePoweredOn</code>. A state below <code>CBCentralManagerStatePoweredOn</code>
 *                  implies that scanning has stopped and any connected peripherals have been disconnected. If the state moves below
 *                  <code>CBCentralManagerStatePoweredOff</code>, all <code>CBPeripheral</code> objects obtained from this central
 *                  manager become invalid and must be retrieved or discovered again.
 *
 *  @see            state
 *
 */
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

/*!
 *  @method centralManager:willRestoreState:
 *
 *  @param central      The central manager providing this information.
 *  @param dict			A dictionary containing information about <i>central</i> that was preserved by the system at the time the app was terminated.
 *
 *  @discussion			For apps that opt-in to state preservation and restoration, this is the first method invoked when your app is relaunched into
 *						the background to complete some Bluetooth-related task. Use this method to synchronize your app's state with the state of the
 *						Bluetooth system.
 *
 *  @seealso            CBCentralManagerRestoredStatePeripheralsKey;
 *  @seealso            CBCentralManagerRestoredStateScanServicesKey;
 *  @seealso            CBCentralManagerRestoredStateScanOptionsKey;
 *
 */
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    
}

/*!
 *  @method centralManager:didDiscoverPeripheral:advertisementData:RSSI:
 *
 *  @param central              The central manager providing this update.
 *  @param peripheral           A <code>CBPeripheral</code> object.
 *  @param advertisementData    A dictionary containing any advertisement and scan response data.
 *  @param RSSI                 The current RSSI of <i>peripheral</i>, in dBm. A value of <code>127</code> is reserved and indicates the RSSI
 *								was not available.
 *
 *  @discussion                 This method is invoked while scanning, upon the discovery of <i>peripheral</i> by <i>central</i>. A discovered peripheral must
 *                              be retained in order to use it; otherwise, it is assumed to not be of interest and will be cleaned up by the central manager. For
 *                              a list of <i>advertisementData</i> keys, see {@link CBAdvertisementDataLocalNameKey} and other similar constants.
 *
 *  @seealso                    CBAdvertisementData.h
 *
 */
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    NSLog(@"scan peripheral name :%@",peripheral.name);
    if ([peripheral.name rangeOfString:@"SH"].length <= 0) {
        return;
    }
    
    if (self.nDevices.count <= 0) {
        [_nDevices addObject:peripheral];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"yd.add.new.peripheral" object:nil];
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"yd.add.new.peripheral" object:nil];
    }
    
    return;
}

/*!
 *  @method centralManager:didConnectPeripheral:
 *
 *  @param central      The central manager providing this information.
 *  @param peripheral   The <code>CBPeripheral</code> that has connected.
 *
 *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has succeeded.
 *
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
}

/*!
 *  @method centralManager:didFailToConnectPeripheral:error:
 *
 *  @param central      The central manager providing this information.
 *  @param peripheral   The <code>CBPeripheral</code> that has failed to connect.
 *  @param error        The cause of the failure.
 *
 *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has failed to complete. As connection attempts do not
 *                      timeout, the failure of a connection is atypical and usually indicative of a transient issue.
 *
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
}

/*!
 *  @method centralManager:didDisconnectPeripheral:error:
 *
 *  @param central      The central manager providing this information.
 *  @param peripheral   The <code>CBPeripheral</code> that has disconnected.
 *  @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion         This method is invoked upon the disconnection of a peripheral that was connected by {@link connectPeripheral:options:}. If the disconnection
 *                      was not initiated by {@link cancelPeripheralConnection}, the cause will be detailed in the <i>error</i> parameter. Once this method has been
 *                      called, no more methods will be invoked on <i>peripheral</i>'s <code>CBPeripheralDelegate</code>.
 *
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    // 失去和外围设备连接后重建连接
    if ([self.peripheral.name rangeOfString:@"SH"].length > 0) {
        [self.manager connectPeripheral:self.peripheral options:nil];
    }
}

@end
