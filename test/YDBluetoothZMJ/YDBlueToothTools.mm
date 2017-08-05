//
//  YDBlueToothTools.m
//  DoStyle
//
//  Created by zmj on 14-8-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "YDBlueToothTools.h"
#import "TimeConversion.h"
#import "YDBleCycleBuffer.h"
#import "YDTools.h"
#import "YDHeartbeatTool.h"
#import "YDDB.h"

@implementation YDBlueToothTools
{
    CBCentralManager *_manager;
    NSInteger _sum;
    NSInteger _saveNum;
}

static YDBlueToothTools *singleton;

+(YDBlueToothTools *)shareBlueToothTools
{
    if (singleton==nil) {
        singleton=[[YDBlueToothTools alloc]init];
    }
    return singleton;
}

-(id)init
{
    self= [super init];
    if(self)
    {
        [self initData];
    }
    return self;
}

-(void)saveSyncModel {
    
}


-(void)initData
{
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
//    _sportTool = [YDSportTool shareSportTool];
    
    _nDevices = [[NSMutableArray alloc]init];
    _nServices = [[NSMutableArray alloc]init];
    _nCharacteristics = [[NSMutableArray alloc]init];

    _syncModel = [[YDBraceletSynchronizeModel alloc]init];
    _saveNum = 0;
    _peripheralUUID = @"bluetooth_device";
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];

//    _stepTarget = [userdf objectForKey:STEP_TARGET_DAY];
    if (_stepTarget == nil)
    {
        _stepTarget = [NSNumber numberWithInteger:10000];
    }
    _filmwareVersionSeq = 0;
    
//    _lastPeripheralUUID = [userdf objectForKey:LAST_BAND_Y_UUID];
    if (_lastPeripheralUUID != nil) {
//        _sportTool.isBandBind = YES;
//        NSLog(@"lastPeripheralUUID == %@",_lastPeripheralUUID);
        _isAutoConnect = YES;
        _peripheralUUID = _lastPeripheralUUID;
        _deviceSeq = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"device_seq_%@",_peripheralUUID]];
//        [YDSportTool shareSportTool].braceletDeviceSeq = _deviceSeq;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:NO] forKey:@"is_connect_off_sync"];
        [self scanClick];
    }
}

- (void)scanClick
{
    /*

     */
    [_nDevices removeAllObjects];
    [self updateLog:@"正在扫描外设..."];
    //[_activity startAnimating];
    [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    double delayInSeconds = 30.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.manager stopScan];
        //        [_activity stopAnimating];
        [self updateLog:@"扫描超时,停止扫描"];
        if (_connectDelegate &&[_connectDelegate respondsToSelector:@selector(loadScanFailedView)]) {
            [_connectDelegate loadScanFailedView];
        }
        NSNumber *isConnectOffSync = [[NSUserDefaults standardUserDefaults] objectForKey:@"is_connect_off_sync"];
        if (isConnectOffSync.boolValue) {
            if (_syncDelegate &&[_syncDelegate respondsToSelector:@selector(loadScanFailedView)]) {
                [_syncDelegate connectOffSyncFail];
            }
        }
    });

}

- (void)connectClick{
    [self.manager connectPeripheral:_peripheral options:nil];
}
- (void)connectOffClick
{
    if (_peripheral != nil) {
        [self.manager cancelPeripheralConnection:_peripheral];
    }
    _peripheral = nil;
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    [userdf setObject:nil forKey:@"last_band_y_UUID"];
//    _sportTool.isBandBind = NO;
    _lastPeripheralUUID = nil;
    _isGetDeviceSeq = NO;
//    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"bracelet_step_save_date"];
//    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"bracelet_save_step"];
}

-(void)writeChar:(NSData *)data
{
    [_peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

//连接



//报警
-(void)sendClick:(UIButton *)bu
{
    unsigned char data = 0x02;
    [_peripheral writeValue:[NSData dataWithBytes:&data length:1] forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
}
//开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
        [self updateLog:@"蓝牙已打开,请扫描外设"];
        break;
        case CBCentralManagerStatePoweredOff:
//        [self showCentralManagerStatePoweredOffAlert];
        break;
        default:
        break;
    }
}

- (void)showCentralManagerStatePoweredOffAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message: @"YDBandVTools.openBlueTooth.text" delegate:self cancelButtonTitle: @"common.well" otherButtonTitles:nil, nil];
    [alert show];
}

//查到外设后，停止扫描，连接设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *updatelogStr =[NSString stringWithFormat:@"已发现 peripheral: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.identifier, advertisementData];
    /*
     _peripheral = peripheral;
     */
    [self updateLog:updatelogStr];
    /*
     [self.manager stopScan];
     */
    //[_activity stopAnimating];
    BOOL replace = NO;
    // Match if we have this device from before
    for (int i=0; i < _nDevices.count; i++) {
        CBPeripheral *p = [_nDevices objectAtIndex:i];
        if ([p isEqual:peripheral]) {
            [_nDevices replaceObjectAtIndex:i withObject:peripheral];
            replace = YES;
//            [self.manager stopScan];
        }
    }
    if (!replace) {
        [_nDevices addObject:peripheral];
        if (_isAutoConnect) {
            NSString *tempUUID = [NSString stringWithFormat:@"%@",peripheral.identifier];
            NSArray *arr=[tempUUID componentsSeparatedByString:@" "];
            tempUUID=[arr lastObject];
//            NSLog(@"tempUUID == %@",tempUUID);
            if ([tempUUID isEqualToString:_lastPeripheralUUID]) {
                _peripheral = peripheral;
                [self connectClick];
                [self.manager stopScan];
            }
        }
        if (_connectDelegate && [_connectDelegate respondsToSelector:@selector(loadDeviceList)]) {
            [_connectDelegate loadDeviceList];
        }
        //        [_deviceTable reloadData];
    }
}

//连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [self updateLog:[NSString stringWithFormat:@"成功连接 peripheral: %@ with UUID: %@",peripheral,peripheral.identifier]];
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
    [self updateLog:@"扫描服务"];
    _peripheralUUID = [NSString stringWithFormat:@"%@",peripheral.identifier];
    NSArray *arr=[_peripheralUUID componentsSeparatedByString:@" "];
    _peripheralUUID=[arr lastObject];
    _syncModel.peripheralUUID = _peripheralUUID;
    _isConnect = YES;
//    _sportTool.isBraceletConnect = YES;
//    _sportTool.bandType = BandTypeY;
//    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
//    [userdf setObject:_peripheralUUID forKey:LAST_BAND_Y_UUID];

    NSString *compareDeviceSeq = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"device_seq_%@",_peripheralUUID]];
    if (_deviceSeq != nil && compareDeviceSeq != nil) {
        if (![_deviceSeq isEqualToString:compareDeviceSeq]) {
            _deviceSeq = nil;
            _isGetDeviceSeq = NO;
//            [YDSportTool shareSportTool].braceletDeviceSeq = _deviceSeq;
        }
        else
        {
            NSNumber *isConnectOffSync = [[NSUserDefaults standardUserDefaults] objectForKey:@"is_connect_off_sync"];
            if (isConnectOffSync.boolValue) {
                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:NO] forKey:@"is_connect_off_sync"];
                [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(startDataSync) userInfo:nil repeats:NO];
//                [self startDataSync];
            }
        }
    }
    _isScan = NO;
    if (_connectDelegate && [_connectDelegate respondsToSelector:@selector(loadConnectSuccessView)]) {
        [_connectDelegate loadConnectSuccessView];
    }
    if (_meDelegate && [_meDelegate respondsToSelector:@selector(refreshMeVCUI)]) {
        [_meDelegate refreshMeVCUI];
    }
    if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(refreshFootConnectView)]) {
        [_syncDelegate refreshFootConnectView];
    }
//    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(bondDevice) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(readDeviceInfo) userInfo:nil repeats:NO];

    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(setSystemTime) userInfo:nil repeats:NO];
}
//连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
//    NSLog(@"error == %@",error);
    if (_meDelegate && [_meDelegate respondsToSelector:@selector(refreshMeVCUI)]) {
        [_meDelegate refreshMeVCUI];
    }
    if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(refreshFootConnectView)]) {
        [_syncDelegate refreshFootConnectView];
    }
    if(_peripheral != nil && !_isUpdataConnectOff)
    {
        [self connectClick];
    }
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
//    NSLog(@"%@", MSLocalizedString(@"disconnect",@"断开连接"));
    _isConnect = NO;
//    _sportTool.isBraceletConnect = YES;

    if (_meDelegate && [_meDelegate respondsToSelector:@selector(refreshMeVCUI)]) {
        [_meDelegate refreshMeVCUI];
    }
    if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(refreshFootConnectView)]) {
        [_syncDelegate refreshFootConnectView];
    }
    if(_peripheral != nil && !_isUpdataConnectOff)
    {
        [self connectClick];
    }
}

-(void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    //NSLog(@"%s,%@",__PRETTY_FUNCTION__,peripheral);
    int rssi = abs([peripheral.RSSI intValue]);
    CGFloat ci = (rssi - 49) / (10 * 4.);
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm",_peripheral,pow(10,ci)];
//    NSLog(@"距离：%@",length);
}
//已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    [self updateLog:@"发现服务."];
    int i=0;
    for (CBService *s in peripheral.services) {
        [self.nServices addObject:s];
    }
    for (CBService *s in peripheral.services) {
        [self updateLog:[NSString stringWithFormat:@"%d :服务 UUID: %@(%@)",i,s.UUID.data,s.UUID]];
        i++;
        [peripheral discoverCharacteristics:nil forService:s];
    }
}

//已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    [self updateLog:[NSString stringWithFormat:@"发现特征的服务:%@ (%@)",service.UUID.data ,service.UUID]];
    
    for (CBCharacteristic *c in service.characteristics) {
        [self updateLog:[NSString stringWithFormat:@"特征 UUID: %@ (%@)",c.UUID.data,c.UUID]];
//        NSLog(@"c.UUID = %@",c.UUID);//FFF2 发数据
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]) {
            _writeCharacteristic = c;
        }
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
            _readCharacteristic = c;
            [self startSubscribe];
            //            [_peripheral readValueForCharacteristic:c];
        }
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFA1"]]) {
            [_peripheral readRSSI];
        }
        
        //        _writeCharacteristic = c;//+
        
        [_nCharacteristics addObject:c];
    }
}

//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    // BOOL isSaveSuccess;
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
        if (characteristic.value != nil) {
//            NSLog(@"%@",[data description]);
            [[YDBleCycleBuffer sharedInstance] put:characteristic.value];
            NSData *unit = [[YDBleCycleBuffer sharedInstance]getUnit];
            while (nil != unit) {
               [self readByteWithData:unit];
                unit = [[YDBleCycleBuffer sharedInstance] getUnit];
            }
            
        }
        //        NSString *value = [[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        //        NSLog(@"电量%f",_batteryValue);
    }
}

//将视频保存到目录文件夹下
-(BOOL)saveToDocument:(NSData *) data withFilePath:(NSString *) filePath
{
    if ((data == nil) || (filePath == nil) || [filePath isEqualToString:@""]) {
        return NO;
    }
    @try {
        //将视频写入指定路径
        [data writeToFile:filePath atomically:YES];
        return  YES;
    }
    @catch (NSException *exception) {
//        NSLog(@"保存失败");
    }
    return NO;
}

//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"didUpdateNotificationStateForCharacteristic");
    
    NSLog(@"characteristic.UUID = %@",characteristic.UUID);
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    // Notification has started
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
        
    } else { // Notification has stopped
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}
//用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"peripheral= %@",peripheral);
    if (error) {
        NSLog(@"=======%@",error.userInfo);
    }else{
        NSLog(@"发送数据成功");
    }
}

//textView更新
-(void)updateLog:(NSString *)s
{
    static unsigned int count = 0;
    NSLog(@"%@",[NSString stringWithFormat:@"[ %d ]  %@\r\n%@",count,s,_infoText]);
    count++;
}

#pragma mark--功能设置
-(void)startRealtimeStep//开启实时计步
{
    Byte header = (Byte) 0x81;
    Byte data[] = {0x01,0x01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * app向ble设备设置短睡时间（2Bytes 有符号数 会打印）
 * 说明：Period，30代表30分钟
 *
 * @return
 */

-(void)setTimeNotifyWithPeriod:(NSInteger)period//短睡
{
    Byte header = (Byte) 0x82;
    Byte intervalL = (Byte) (period & 0XFF);
    Byte intervalH = (Byte) (period >> 8 & 0XFF);
    Byte data[] = {0x01, intervalL, intervalH};
    
    NSData *data0 = [[NSData alloc] initWithBytes:data length:3];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 取消短睡时间提醒
 *
 * @return
 */
-(void)cancelTimeNotify//取消短睡
{
    Byte header = (Byte) 0x82;
    Byte data[] = {0x01, 0x00, 0x00};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:3];
    [self writeByteWithHeader:header andData:data0];
}


-(void)startDataSync//获取历史数据
{
    Byte header = (Byte) 0x90;
    Byte data[] = {0x01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:1];
    [self writeByteWithHeader:header andData:data0];
}


/**
 * 开始查找ble设备
 * @return
 */
-(void)startSearchBle
{
    Byte header = (Byte) 0x83;
    Byte data[] = {0x01, 0x01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 结束查找ble设备
 * @return
 */
-(void)endSearchBle
{
    Byte header = (Byte) 0x83;
    Byte data[] = {0x01, 0x00};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * app向ble设备 设置近距离防丢报警
 * @return
 */
-(void)setShortDistanceLostRemind
{
    Byte header = (Byte) 0x83;
    Byte data[] = {0x02, 0x01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * app向ble设备 设置远距离防丢报警
 * @return
 */
-(void)setLongDistanceLostRemind
{
    Byte header = (Byte) 0x83;
    
    Byte data[] = {0x02, 0x02};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}
/**
 * app向ble设备 关闭防丢报警
 * @return
 */
-(void)turnOffLostRemind
{
    Byte header = (Byte) 0x83;
    Byte onByte = (Byte) (0x00);
    
    Byte data[] = {0x02, onByte};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 读取设备信息
 *
 * @return
 */
-(void)readDeviceInfo
{
    Byte header = (Byte) 0xF0;
    Byte data[] = {0x01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:1];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 读取固件信息
 *
 * @return
 */
-(void)readFilmwareInfo
{
    Byte header = (Byte) 0xF0;
    Byte data[] = {0x02};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:1];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 发起数据同步结果
 *
 * @return
 */
-(void)sendDataSyncResultWithBool:(BOOL)isSuccess
{
    Byte header = (Byte) 0x90;
    Byte code = (Byte) (isSuccess?0x01 : 0x00);
    Byte data[] = {0x02,code};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/*
 public boolean successSyncStep() {
 byte header = (byte) 0x90;
 byte[] data = new byte[] { 0x02, 0x01 };
 return writeByte(header, data);
 }
 */

/**
 * 个人信息设置 app向ble设备设置个人信息（5Bytes） 身高 体重 性别 年龄 测量单位 1Byte 1Byte 1Byte 1Byte
 * 1Byte 说明：身高(cm)、体重(kg)、性别(0x00 男，0x01 女)，测量单位(0x00 公制，0x01英制)不支持小数
 *
 * @return
 */
-(void)setPhysicWithHeight:(int)height
                 andWeight:(int)weight
                    andSex:(Byte)sex
                    andAge:(Byte)age
                   andUnit:(Byte)unit
{
    Byte header = (Byte) 0xB0;
    Byte heightL = (Byte) (height & 0XFF);
    Byte heightH = (Byte) (height >> 8 & 0XFF);
    Byte weightL = (Byte) (weight & 0XFF);
    Byte weightH = (Byte) (weight >> 8 & 0XFF);
    Byte data[] = {0x01, heightL, heightH, weightL, weightH,
        sex, age, unit};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:8];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * app向ble设备同步系统时间（7Bytes 有符号数） Year Month Day Hour Min Sec 2Bytes 1Byte
 * 1Byte 1Byte 1Byte 1Byte 说明：Year低字节在前。每次连接上，都要同步系统时间。
 *
 */

-(void)setSystemTime
{
    //得到时间
    if (_isConnect) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"yyyy:MM:dd:HH:mm:ss"];
        NSString *str=[dateFormatter stringFromDate:[NSDate date]];
        NSArray *arr=[str componentsSeparatedByString:@":"];
        if (arr.count == 6) {
            int year = ((NSString *)arr[0]).intValue;
            int month = ((NSString *)arr[1]).intValue;
            int day = ((NSString *)arr[2]).intValue;
            int hour = ((NSString *)arr[3]).intValue;
            int min = ((NSString *)arr[4]).intValue;
            int sec = ((NSString *)arr[5]).intValue;
            
            [self setSystemTimeWithYear:year andMonth:(Byte)month andDay:(Byte)day andHour:(Byte)hour andMin:(Byte)min andSec:(Byte)sec];
        }
    }
}

-(void)setSystemTimeWithYear:(int)year
                    andMonth:(Byte)month
                      andDay:(Byte)day
                     andHour:(Byte)hour
                      andMin:(Byte)min
                      andSec:(Byte)sec
{
    Byte header = (Byte) 0x84;
    Byte yearL = (Byte) (year & 0XFF);
    Byte yearH = (Byte) (year >> 8 & 0XFF);
    Byte data[] = { 0x01, yearL, yearH, month, day, hour, min, sec};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:8];
    [self writeByteWithHeader:header andData:data0];
}



/**
 * app向ble设备设置闹钟（4Bytes 有符号数） Number Statu Hour Min 1Byte 1Byte 1Byte 1Byte
 * 说明： Number：0x01 设置闹钟1, 0x02 设置闹钟2 Statu
 * :0x01星期日、0x02星期一、0x04星期二、0x08星期三、0x10星期四、0x20星期五、0x40星期六，如Statu
 * 0x3E表示工作日期间闹钟有效
 *
 public boolean setClock(byte clock, byte stat, byte hour, byte min) {
 byte header = (byte) 0x84;
 byte[] data = new byte[] { 0x02, stat, hour, min };
 return writeByte(header, data);
 }
 */
-(void)setClockWithClock:(Byte)clock
                andStatu:(Byte)statu
                 andHour:(Byte)hour
                  andMin:(Byte)min
{
    Byte header = (Byte) 0x84;
    Byte data[] = { 0x02,clock, statu, hour, min};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:5];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 发送读取闹钟信息指令
 *
 * @return
 */
-(void)readClock
{
    Byte header = (Byte) 0x84;
    Byte data[] = {0x04};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:1];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * app向ble设备设置整点提醒
 *
 * @param on
 *            是否提醒
 public boolean switchHourRemind(boolean on) {
 byte header = (byte) 0x84;
 byte onByte = (byte) (on ? 0x01 : 0x00);
 byte[] data = new byte[] { 0x03, onByte };
 return writeByte(header, data);
 }
 
 */
-(void)switchHourRemindWithIsON:(BOOL)isOn
{
    Byte header = (Byte) 0x84;
    Byte onByte = (Byte) (isOn ? 0x01 : 0x00);
    Byte data[] = {0x03, onByte};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 *
 * 个人信息设置:设置信息 app向ble设备设置用户姓名（16Bytes） 1~16Bytes
 * 说明：UTF8格式如果姓名大于16字节，则保留前16字节
 *
 public boolean setBarceletName(String name) {
 byte header = (byte) 0xB0;
 byte[] nameBytes = name.getBytes(Charset.forName("utf-8"));
 byte[] data = new byte[1 + nameBytes.length];
 data[0] = 0x02;
 System.arraycopy(nameBytes, 0, data, 1, nameBytes.length);
 return writeByte(header, data);
 }
 */
-(void)setBarceletNameWithName:(NSString *)name
{
    Byte header = (Byte) 0x84;
    NSData* nameData = [name dataUsingEncoding:NSUTF8StringEncoding];
    
//    Byte *nameBytes = (Byte*)[nameData bytes];
    Byte data[1 + nameData.length];
    data[0] = 0x02;
    //    System.arraycopy(nameBytes, 0, data, 1, nameBytes.length);
    
    NSData *data0 = [[NSData alloc] initWithBytes:data length:1 + nameData.length];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 结束实时计步
 *
 public boolean stopRealtimeStep() {
 byte header = (byte) 0x81;
 byte[] data = new byte[] { 0x01, 0x00 };
 return writeByte(header, data);
 }
 */
-(void)stopRealtimeStep
{
    Byte header = (Byte) 0x81;
    Byte data[] = {0x01,0x00};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 开启心率测试
 *
 public boolean startHeartRateTest() {
 byte header = (byte) 0x80;
 byte[] data = new byte[] { 0x01, 0x01 };
 return writeByte(header, data);
 }
 */
-(void)startHeartRateTest
{
    Byte header = (Byte) 0x80;
    Byte data[] = {0x01,0x01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 开启电池电量监控
 *
 * @return
 */
-(void)startEnergyWatch
{
    Byte header = (Byte) 0xF1;
    Byte data[] = {0x01,0x01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 关闭电池电量监控
 *
 * @return
 */
-(void)endEnergyWatch
{
    Byte header = (Byte) 0xF1;
    Byte data[] = {0x01,0x00};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

/**
 * 目前只进行统一来电处理 app向ble设备设置来电提醒、短信推送类型、以及消息条数（2Bytes 有符号数） NotifyInfo 2Bytes
 *
 * @return
 */
-(void)newCallNotify
{
    Byte header = (Byte) 0x85;
    Byte data[] = {0x01, 0X01, 0X01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:3];
    [self writeByteWithHeader:header andData:data0];
    
    Byte data1[] = {0x02, 0X02};
    NSData *data10 = [[NSData alloc] initWithBytes:data1 length:2];
    [self writeByteWithHeader:header andData:data10];
}

/**
 * 来电未接，取消震动
 *
 * @return
 */
-(void)cancelCallNotify
{
    Byte header = (Byte) 0x85;
    Byte data[] = {0x01, 0X02, 0X01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:3];
    [self writeByteWithHeader:header andData:data0];
}
/**
 * 来电已接，取消震动
 *
 * @return
 */
-(void)holdCallNotify
{
    Byte header = (Byte) 0x85;
    Byte data[] = {0x01, 0X08, 0X01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:3];
    [self writeByteWithHeader:header andData:data0];
}
/**
 *
 * 新的讯息
 *
 * @return
 */
-(void)newMessageNotify
{
    Byte header = (Byte) 0x85;
    Byte data[] = {0x01, 0X04, 0X01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:3];
    [self writeByteWithHeader:header andData:data0];
    
    Byte data1[] = {0x02,0x01,0x01,0x00,0x30,0x03,0x01,0x00,0x30,0x05,0x01,0x00,0x30};
    NSData *data10 = [[NSData alloc] initWithBytes:data1 length:13];
    [self writeByteWithHeader:header andData:data10];
}

/**
 * 重置设备
 */
-(void)resetDevice
{
    Byte header = (Byte) 0xb0;
    Byte data[] = {0x04};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:1];
    [self writeByteWithHeader:header andData:data0];
}
/*
 绑定设备
*/
-(void)bondDevice
{
    Byte header = (Byte) 0xe0;
    Byte data[] = {0x02,0x01};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}
/*
 解绑设备
 */
-(void)bondOffDevice
{
    Byte header = (Byte) 0xe0;
    Byte data[] = {0x02,0x00};
    NSData *data0 = [[NSData alloc] initWithBytes:data length:2];
    [self writeByteWithHeader:header andData:data0];
}

#pragma mark--写数据

- (void)writeDataWithByte:(NSData*)data {
    [_peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

-(void)startSubscribe
{
    [_peripheral setNotifyValue:YES forCharacteristic:_readCharacteristic];
}


-(void)writeByteWithHeader:(Byte)header andData:(NSData *)data
{
    NSData *encodeData0=[self writeProtocolDataBytesWithData:data];

    Byte *encodeData = (Byte *)[encodeData0 bytes];
    NSInteger encodeDataLength = encodeData0.length;
    Byte byte_send[3 + encodeDataLength];
    byte_send[0] = header;
    byte_send[1] = (Byte) (encodeDataLength + 1);
    for (int i = 2; i < encodeDataLength + 2; i++) {
        byte_send[i] = encodeData[i - 2];
    }
    fillCheckSumByte(byte_send,encodeDataLength+3);
    
    Boolean isValid = isCheckSumValid(byte_send,encodeDataLength+3);
    if (!isValid) {
        NSLog(@"校验失败");
        //        throw new RuntimeException("校验失败");
    }
    
    NSData *sendData = [[NSData alloc] initWithBytes:byte_send length:encodeData0.length + 3];
    [self writeDataWithByte:sendData];
}

-(NSData *)writeProtocolDataBytesWithData:(NSData *)sData
{
    int n = 0;
    int i, j, leastBit = 0;
    int bit7 = 0;
    
    Byte *sDataB = (Byte *)[sData bytes];
    
    NSInteger sDataBLength = sData.length;
    NSInteger count = (sDataBLength * 8 + 7 - 1) / 7;
    Byte d[count];
    for(int i = 0;i<count;i++)
    {
        d[i] = 0;
    }
    
    for (i = 0; i < sData.length; i++) {
        for (j = 0; j < 8; j++) {
            leastBit = (sDataB[i] >> j) & 0x01;
            //            NSLog(@"leastBit=%x",leastBit);
            d[n] |= leastBit << (bit7++);
            //            NSLog(@"d[%d]==%d",n,d[n]);
            if (7 == bit7) {
                bit7 = 0;
                n++;
            }
        }
    }
    NSData *dData = [[NSData alloc]initWithBytes:d length:count];
    return dData;
}

void fillCheckSumByte(Byte buf[] ,NSInteger bufLength) {
    Byte checksum = 0;
    int i;
    for (i = 0; i < bufLength - 1; i++)
    checksum = (Byte) (checksum + buf[i]);
    checksum = (Byte) (((~checksum) + 1) & 0x7F);
    buf[bufLength - 1] = checksum;
}

Boolean isCheckSumValid(Byte *rcvBuff, NSInteger rcvBuffLength) {
    Byte checksum = rcvBuff[0];
    int i = 0;
    
    for (i = 1; i < rcvBuffLength; i++) {
        if (rcvBuff[i] >= 0x80)
        return false;
        checksum = (Byte) (checksum + rcvBuff[i]);
    }
    checksum &= 0x7F;
    if (0 == checksum)
    return true;
    return false;
}


#pragma mark--解包
-(void)readByteWithData:(NSData*)DataD {
    //    Byte *data = (Byte *)[DataD bytes];
    NSData *playloadData =[self decodeDataWithData:DataD];
    if (playloadData.length==0 || playloadData == nil) {
        return;
    }
    Byte* playload = (Byte *)[playloadData bytes];
    Byte headerId = playload[0];
    Byte *dataB = (Byte *)[DataD bytes];
    
    switch (dataB[0]) {
        // 心率，暂不支持
		case (Byte) 0x80: {
			if (headerId == (Byte) 0x81) {
                
			}
			break;
		}
        
        /***
         * 计步
         *
         *
         * ble设备上传计步器实时值（6Bytes 有符号数） 步数 卡路里 距离 2Bytes 2Bytes 2Bytes
         * 说明：低字节先传，一旦有新的计步数据就上传(不定时)
         */
		case (Byte) 0x81: {
			if (headerId == (Byte) 0x81) {
				int step = (int) (playload[1] & 0XFF)
                + (int) ((playload[2] & 0XFF) << 8);
				int calorie = (int) (playload[3] & 0XFF)
                + (int) ((playload[4] & 0XFF) << 8);
				int distance = (int) (playload[5] & 0XFF)
                + (int) ((playload[6] & 0XFF) << 8);
                _todayStepNum = step;
                _todayCalorie = calorie;
                _todayDistance = distance;
//                _sportTool.braceletStep = step;
//                _sportTool.braceletStepDate = [NSDate date];
//
//                [YDUserInstance new_setBandSteps:_todayStepNum];
//                [YDUserInstance new_setBandStepTime:[NSDate date]];

                if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(refreshFootVCUI)]) {
                    [_syncDelegate refreshFootVCUI];
                }
            }
			break;
		}
            
            
            /***
             * Statu:0x00表示关闭相应的闹钟
             *
             * 读取闹钟信息
             */
		case (Byte) 0x84: {
			if (headerId == (Byte) 0x81) {
				int number = (int) (playload[1] & 0XFF);
				int status = (int) (playload[2] & 0XFF);
				int hour = (int) (playload[3] & 0XFF);
				int min = (int) (playload[4] & 0XFF);
                NSLog(@"%d--%d--%d--%d",number,status,hour,min);
                if (_normalClockDelegate && [_normalClockDelegate respondsToSelector:@selector(loadClockWithNumber:andStatus:andHour:andMin:)]) {
                    [_normalClockDelegate loadClockWithNumber:number andStatus:status andHour:hour andMin:min];
                }
//				Alarm alarm = new Alarm();
//				alarm.setClock(number);
//				alarm.setRepeateMode(status);
//				alarm.setHour(hour);
//				alarm.setMinute(min);
//				AlarmDBHelper.getInstance(context).modifyAlarm(alarm);
			}
			break;
		}
        /***
         * 历史数据同步
         *
         *
         */
		case (Byte) 0x90: {
			// 无历史数据
			if (headerId == (Byte) 0x80) {
				/****
				 * ble设备上传空包，表示无历史数据同步（2Bytes） 0x00 0x00
				 */
//				int flag1 = (int) (playload[1] & 0XFF);
//				int flag2 = (int) (playload[2] & 0XFF);
                NSLog(@"无历史数据");
                if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(blueToothSyncWithEmptyPack)]) {
                    [_syncDelegate blueToothSyncWithEmptyPack];
                }
				
			} else if (headerId == (Byte) 0x81) {
				/****
				 * 数据起始包 ble设备上传起始包 Year Month Day Hour Min Sec Sum 2Bytes 1Byte
				 * 1Byte 1Byte 1Byte 1Byte 2Bytes
				 */
                NSLog(@"上传开始");
				int year = (int) (playload[1] & 0XFF)
                + (int) ((playload[2] & 0XFF) << 8);
				int month = (int) (playload[3] & 0XFF);
				int day = (int) (playload[4] & 0XFF);
				int hour = (int) (playload[5] & 0XFF);
				int min = (int) (playload[6] & 0XFF);
				int sec = (int) (playload[7] & 0XFF);
				_sum = (int) (playload[8] & 0XFF)
                + (int) ((playload[9] & 0XFF) << 8);
                NSLog(@"%d-%d-%d-%d-%d-%d-%ld",year,month,day,hour,min,sec,(long)_sum);
                _saveNum = 0;
                if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(blueToothStartSyncWithSum:)]) {
                    [_syncDelegate blueToothStartSyncWithSum:_sum];
                }
                [self clearSyncModelWithNum:_sum completion:nil];
                
			} else if (headerId == (Byte) 0x82) {
				/****
				 * ble设备上传数据包 Number 步数 卡路里 距离 睡眠 2Bytes 2Bytes 2Bytes 2Bytes
				 * 2Bytes
				 */
				int seq = (int) (playload[1] & 0XFF)
                + (int) ((playload[2] & 0XFF) << 8);
				int step = (int) (playload[3] & 0XFF)
                + (int) ((playload[4] & 0XFF) << 8);
				int calorie = (int) (playload[5] & 0XFF)
                + (int) ((playload[6] & 0XFF) << 8);
				int distance = (int) (playload[7] & 0XFF)
                + (int) ((playload[8] & 0XFF) << 8);
				int sleep = (int) (playload[9] & 0XFF)
                + (int) ((playload[10] & 0XFF) << 8);
                
//                NSLog(@"%d-%d-%d-%d-%d",seq,step,calorie,distance,sleep);
                if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(blueToothSyncingWithSeq:)]) {
                    [_syncDelegate blueToothSyncingWithSeq:seq];
                }
                [self savePointWithSeq:seq andStep:step andCalorie:calorie andDistance:distance andSleep:sleep];
			} else if (headerId == (Byte) 0x83) {
				/****
				 * ble设备上传结束包（2Bytes） 0x11 0x11
				 */
//				int flag1 = (int) (playload[1] & 0X11);
//				int flag2 = (int) (playload[2] & 0X11);
                NSLog(@"上传结束");

                if (!_syncModel.isSave) {
                    [self saveSyncModelWithCompletion:^{
                        if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(blueToothEndSync)]) {
                            [_syncDelegate blueToothEndSync];
                        }
                        
                        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"bracelet_last_time"];
                        
                        YDHeartbeatTool *heartbeatTool = [YDHeartbeatTool shareHeartbeatTool];
                        if (!heartbeatTool.isBraceletDayUpload) {
                            [heartbeatTool uploadBraceletDayDataWithCompletion:^{
                                [self sendDataSyncResultWithBool:YES];
                            }];
                        }
                    }];
                } else {
                    if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(blueToothEndSync)]) {
                        [_syncDelegate blueToothEndSync];
                    }
                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"bracelet_last_time"];
                    
                    YDHeartbeatTool *heartbeatTool = [YDHeartbeatTool shareHeartbeatTool];
                    if (!heartbeatTool.isBraceletDayUpload) {
                        [heartbeatTool uploadBraceletDayDataWithCompletion:^{
                            [self sendDataSyncResultWithBool:YES];
                        }];
                    }
                }
			}
            
			break;
		}
        
        /***
         * 设备信息
         */
		case (Byte) 0xF0: {
			if (headerId == (Byte) 0x81) {
				/****
				 * ble设备上传设备信息（22Bytes） 固件版本 硬件版本 3Bytes 3Bytes
				 * 说明：ble设备与app建立连接后直接发送设备信息
				 */
				// String seq = new String(data, 1, 16);
                NSRange romVerRange = {1,3};
                _romVer = [[NSString alloc]initWithData:[playloadData subdataWithRange:romVerRange] encoding:NSUTF8StringEncoding];
                
                NSRange hardwareVerRange = {4,3};
                _hardwareVer = [[NSString alloc]initWithData:[playloadData subdataWithRange:hardwareVerRange] encoding:NSUTF8StringEncoding];

			} else if (headerId == (Byte) 0x82) {
				/****
				 * ble设备上传生产厂家（25Bytes） 生产厂家 nBytes 说明：ble设备与app建立连接后直接发送生产厂家
				 * （最大25Bytes）
				 */
                
                NSRange manufactrueRange = {1,playloadData.length-1};
                _manufactrue = [[NSString alloc]initWithData:[playloadData subdataWithRange:manufactrueRange] encoding:NSUTF8StringEncoding];

			} else if (headerId == (Byte) 0x83) {
				/****
				 * ble设备上传序列号（10Bytes ASCII） 序列号10Bytes 例如：序 列 号：“0123456789”
				 * 说明：ble设备与app每次连接上都要发送序列号
				 */
                
                NSRange seqRange = {1,playloadData.length-1};
                _deviceSeq = [[NSString alloc]initWithData:[playloadData subdataWithRange:seqRange] encoding:NSUTF8StringEncoding];
                _isGetDeviceSeq = YES;
//                [YDSportTool shareSportTool].braceletDeviceSeq = _deviceSeq;

                NSString *compareDeviceSeq = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"device_seq_%@",_peripheralUUID]];
                if (![_deviceSeq isEqualToString:compareDeviceSeq]) {
                    [[NSUserDefaults standardUserDefaults] setObject:_deviceSeq forKey:[NSString stringWithFormat:@"device_seq_%@",_peripheralUUID]];
                    if (_syncDelegate && [_syncDelegate respondsToSelector:@selector(refreshFootConnectView)]) {
                        [_syncDelegate refreshViewWithDeviceSeq:_deviceSeq];
                    }
                }
                NSNumber *isConnectOffSync = [[NSUserDefaults standardUserDefaults] objectForKey:@"is_connect_off_sync"];
                if (isConnectOffSync.boolValue) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:NO] forKey:@"is_connect_off_sync"];
                    [self startDataSync];
                }
                
            }else if (headerId == (Byte) 0x84) {
                /****
                 * ble设备上传固件版本值(2 Byte)
                 (0-1000)
                 如果app获取到的版本值，比服务器的小，则判断为”固件版本低，请升级”；如果大于等于，则判断为”固件版本已经是最新的”；如果没有获取到版本值，则判断为”固件版本低，请升级”
                 */
        
                _filmwareVersionSeq =(int) (playload[1] & 0XFF) + ((int) (playload[2] & 0XFF)<<8);
                NSLog(@"当前版本序号:%ld",(long)_filmwareVersionSeq);

                if (_filmwareDelegate && [_filmwareDelegate respondsToSelector:@selector(loadFilmwareInfo)]) {
                    [_filmwareDelegate loadFilmwareInfo];
                }
            }
			break;
		}
        /***
         * 电池电量
         */
		case (Byte) 0xF1: {
			if (headerId == (Byte) 0x81) {
				/****
				 * ble设备上传电池状态、电池电量 电池状态 电池电量 1Byte 1Byte 说明：电池状态(0x00未充电 0x01充电 0x02充满 0x03电量太低) 电池电量(0 – 100，表示电量百分比)
				 */
				int status = (int) (playload[1] & 0XFF);
				int energy = (int) (playload[2] & 0XFF);
//                NSLog(@"电量(status:%d  energy:%d)",status,energy);
                if (_electricityDelegate && [_electricityDelegate respondsToSelector:@selector(refreshEnergyWithStatus:andEnergy:)]) {
                    [_electricityDelegate refreshEnergyWithStatus:status andEnergy:energy];
                }
			}
			break;
		} 
    }
}


/**
 * 获取数据的解码后负载部分
 *
 * @param data
 * @return
 */
-(NSData *)decodeDataWithData:(NSData *)data
{
    Byte *dataB = (Byte *)[data bytes];
    bool isValid = isCheckSumValid(dataB,data.length);
    //    NSLog(@"isValid:%d",isValid);
    if (!isValid) {
        NSLog(@"接收数据校验失败");
    }
    Byte playload[dataB[1] - 1];
    for (int i = 0; i < dataB[1] - 1; i++) {
        playload[i] = dataB[2 + i];
    }
    return readProtocolDataBytes(playload,dataB[1] - 1);
}

#define TYPE_REALTIME_STEP  @"TYPE_REALTIME_STEP"

#define TYPE_BATTERY_ENERGY @"TYPE_BATTERY_ENERGY"

NSData* readProtocolDataBytes(Byte s[] ,int length) {
    int n = 0;
    Byte bit8 = 0;
    int i, j;
    int leastBit = 0;
    int count = length * 7 / 8;
    Byte d[length];
    for (int i = 0; i<length; i++) {
        d[i] = 0;
    }
    
    for (i = 0; i < length; i++) {
        for (j = 0; j < 7; j++) {
            leastBit = (s[i] >> j) & 0x01;
            d[n] |= leastBit << (bit8++);
            if (8 == bit8) {
                bit8 = 0;
                n++;
            }
        }
    }
    Byte rt[count];
    for (int i =0 ; i < count; i++) {
        rt[i] = d[i];
        //        NSLog(@"rt[%d]=%x",i,rt[i]);
        
    }
    NSData *rtData = [[NSData alloc]initWithBytes:rt length:count];
    return rtData;
}



//根据当前时间将视频保存到VideoFile文件夹中
-(NSString *)imageSavedPath:(NSString *) VideoName
{
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    //获取文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //指定新建文件夹路径
    NSString *videoDocPath = [documentPath stringByAppendingPathComponent:@"VideoFile"];
    //创建VideoFile文件夹
    [fileManager createDirectoryAtPath:videoDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    //返回保存图片的路径（图片保存在VideoFile文件夹下）
    NSString * VideoPath = [videoDocPath stringByAppendingPathComponent:VideoName];
    return VideoPath;
}

#pragma mark--同步记录
-(void)clearSyncModelWithNum:(NSInteger)num completion:(void (^)(void))completion {
    _syncModel.isSave = NO;
//    _syncModel.userID = [YDAppInstance userId];
    if (_syncModel.userID == nil) {
        _syncModel.userID = [NSNumber numberWithInteger:1];
    }
//    _syncModel.syncID = [_myDB localSportIDForNewSport];
    [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//        _syncModel.syncID = [YDDBTable localSportIDForNewSportDb: db];
    } completHandler:^{
        _syncModel.peripheralUUID = _peripheralUUID;
        _syncModel.endTime = [NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970];
        _syncModel.beginTime = [NSNumber numberWithDouble:([NSDate date].timeIntervalSince1970-num*5*60)];
        
        _syncModel.dayNum = [TimeConversion getDayNumWithSecond:_syncModel.beginTime];
        _syncModel.beginNum = [TimeConversion getDaySeqWithSecond:_syncModel.beginTime];
        
        NSNumber *endDayNum = [TimeConversion getDayNumWithSecond:_syncModel.endTime];
        
        if (_syncModel.dayNum.integerValue == endDayNum.integerValue) {
            _syncModel.pointNum = [NSNumber numberWithInteger:num];
            _syncModel.endTime = [NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970];
        }
        else
        {
            _syncModel.pointNum = [NSNumber numberWithInteger:(289-_syncModel.beginNum.integerValue)];
            _syncModel.endTime = [NSNumber numberWithDouble:(_syncModel.beginTime.doubleValue+_syncModel.pointNum.integerValue*60*5)];
        }
        _syncModel.pointDetail = @"";
        if (_syncModel.pointArray == nil) {
            _syncModel.pointArray = [NSMutableArray array];
        }
        else
        {
            [_syncModel.pointArray removeAllObjects];
        }
        if (completion) {
            completion();
        }
    }];
    
}
-(void)savePointWithSeq:(NSInteger)seq andStep:(NSInteger)step andCalorie:(NSInteger)calorie andDistance:(NSInteger)distance andSleep:(NSInteger)sleep
{
    NSMutableDictionary *detailDic=[NSMutableDictionary dictionary];
    NSInteger currentSeq = seq-_saveNum;
    NSInteger daySeq = _syncModel.beginNum.integerValue+currentSeq-1;

    if (daySeq<=288) {
        [detailDic setObject:[NSNumber numberWithInteger:daySeq] forKey:@"seq"];
        [detailDic setObject:[NSNumber numberWithInteger:step] forKey:@"step"];
        [detailDic setObject:[NSNumber numberWithInteger:calorie] forKey:@"calorie"];
        [detailDic setObject:[NSNumber numberWithInteger:distance] forKey:@"distance"];
        [detailDic setObject:[NSNumber numberWithInteger:sleep] forKey:@"sleep"];
        [_syncModel.pointArray addObject:detailDic];
    }
    if (daySeq>=288) {
        [self saveSyncModelWithCompletion:^{
            [self clearSyncModelWithNum:_sum-seq completion:^{
                _saveNum = seq;
                if (daySeq>288) {
                    NSLog(@"出界daySeq==%ld",(long)daySeq);
                }
            }];
        }];
    }
}

- (NSInteger)getDayTimeWithDayNum:(NSNumber *)dayNum{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat  = @"yyyyMMdd-HH:mm:ss";
    NSString *dayZeroStr = [NSString stringWithFormat:@"%@-00:00:00",dayNum];
    NSDate *aDate = [df dateFromString: dayZeroStr];
    return aDate.timeIntervalSince1970;
}

-(void)saveSyncModelWithCompletion:(void (^)(void))completion
{
//    _syncModel.pointDetail=[MSJsonKit objToJson:_syncModel.pointArray withKey:nil];
    
//    [_myDB insertBraceletSyncRecordToDataBase:_syncModel];
//    __block YDBraceletDayModel *dayModel;
    __block NSNumber *syncID = nil;
    [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//        dayModel = [YDDBTable db:db selectBraceletDayRecordFromDataBaseForUserId:[YDAppInstance userId] DayNum:_syncModel.dayNum andDeviceSeq:_deviceSeq];
//        syncID = [YDDBTable localSportIDForNewSportDb: db];
    } completHandler:^() {
//        NSInteger dayTime = [self getDayTimeWithDayNum:_syncModel.dayNum];
//        BOOL isSave=YES;
//        if(dayModel == nil) {
//            isSave = NO;
//            dayModel = [[YDBraceletDayModel alloc]init];
//            dayModel.syncID = syncID;
//            dayModel.dayNum = _syncModel.dayNum;
//            dayModel.userID = _syncModel.userID;
//            dayModel.peripheralUUID = _peripheralUUID;
//            dayModel.deviceSeq = _deviceSeq;
//            NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
//            NSNumber *stepTarget = [userdf objectForKey:STEP_TARGET_DAY];
//            if (stepTarget == nil) {
//                stepTarget = [NSNumber numberWithInteger:10000];
//            }
//            dayModel.stepTarget = stepTarget;
            
//            NSDateFormatter *df = [[NSDateFormatter alloc] init];
//            df.dateFormat  = @"yyyyMMdd-HH:mm:ss";
//            NSString *dayZeroStr = [NSString stringWithFormat:@"%@-00:00:00",dayModel.dayNum];
//            NSDate *aDate = [df dateFromString: dayZeroStr];
//            dayModel.beginTime = [NSNumber numberWithDouble:aDate.timeIntervalSince1970];
//            dayModel.costTime = @86400;
//            [self saveSyncModel:dayModel dayTime:dayTime isSave:isSave completion:completion];
//        } else {
//            [self saveSyncModel:dayModel dayTime:dayTime isSave:isSave completion:completion];
//        }
    }];
}

//- (void)saveSyncModel:(YDBraceletDayModel *)dayModel dayTime:(NSInteger)dayTime isSave:(BOOL)isSave completion:(void (^)(void))completion {
//    dayModel.pointArray = [NSMutableArray arrayWithArray:[MSJsonKit jsonToObj:dayModel.pointDetail asClass:[NSArray class]]];
//    if (dayModel.pointArray == nil) {
//        dayModel.pointArray = [NSMutableArray array];
//    }
//    if (dayModel.pointArray.count == 0) {
//        for (int i =0; i<288; i++) {
//            NSMutableDictionary *detailDic=[NSMutableDictionary dictionary];
//            [detailDic setObject:[NSNumber numberWithInteger:i+1] forKey:@"seq"];
//            [detailDic setObject:[NSNumber numberWithInteger:0] forKey:@"step"];
//            [detailDic setObject:[NSNumber numberWithInteger:0] forKey:@"calorie"];
//            [detailDic setObject:[NSNumber numberWithInteger:0] forKey:@"distance"];
//            [detailDic setObject:[NSNumber numberWithInteger:-1] forKey:@"sleep"];
//            [detailDic setObject:[NSNumber numberWithInteger:(dayTime + i*300)] forKey:@"begin_ts"];
//            [detailDic setObject:[NSNumber numberWithInteger:(dayTime + (i+1)*300)] forKey:@"end_ts"];
//
//            [dayModel.pointArray addObject:detailDic];
//        }
//    }
//    else if (dayModel.pointArray.count<288)
//    {
//        for (NSInteger i = dayModel.pointArray.count-1; i<288; i++) {
//            NSMutableDictionary *detailDic=[NSMutableDictionary dictionary];
//            [detailDic setObject:[NSNumber numberWithInteger:i+1] forKey:@"seq"];
//            [detailDic setObject:[NSNumber numberWithInteger:0] forKey:@"step"];
//            [detailDic setObject:[NSNumber numberWithInteger:0] forKey:@"calorie"];
//            [detailDic setObject:[NSNumber numberWithInteger:0] forKey:@"distance"];
//            [detailDic setObject:[NSNumber numberWithInteger:-1] forKey:@"sleep"];
//            [detailDic setObject:[NSNumber numberWithInteger:(dayTime + i*300)] forKey:@"begin_ts"];
//            [detailDic setObject:[NSNumber numberWithInteger:(dayTime + (i+1)*300)] forKey:@"end_ts"];
//            [dayModel.pointArray addObject:detailDic];
//        }
//    }
//
//    for (int i = 0; i<_syncModel.pointArray.count; i++) {
//        NSMutableDictionary *dic = _syncModel.pointArray[i];
//        NSNumber *daySeq = dic[@"seq"];
//        if(daySeq.integerValue <= 288 && daySeq.integerValue >= 1)
//        {
//            NSDictionary *bDic = dayModel.pointArray[daySeq.integerValue-1];
//            NSNumber *bStep = bDic[@"step"];
//            if (bStep == nil) {
//                bStep = @0;
//            }
//            NSNumber *aStep = dic[@"step"];
//            if (aStep == nil) {
//                aStep = @0;
//            }
//            [dic setObject:[NSNumber numberWithInteger:(dayTime + (daySeq.integerValue-1)*300)] forKey:@"begin_ts"];
//            [dic setObject:[NSNumber numberWithInteger:(dayTime + daySeq.integerValue*300)] forKey:@"end_ts"];
//
//            [dayModel.pointArray replaceObjectAtIndex:daySeq.integerValue-1 withObject:dic];
//            dayModel.steps = [NSNumber numberWithInteger:(dayModel.steps.integerValue + aStep.integerValue - bStep.integerValue)];
//        }
//        else
//        {
//            NSLog(@"出界:dayseq == %ld", (long)(daySeq.integerValue));
//        }
//    }
//    dayModel.distance = [NSNumber numberWithFloat:[YDTools distanceWithStep:dayModel.steps.integerValue]];
//    dayModel.caloric = [NSNumber numberWithFloat:[YDTools calorieWithDistance:dayModel.distance.floatValue]];
//    dayModel.pointDetail = [MSJsonKit objToJson:dayModel.pointArray withKey:nil];
//    dayModel.isUp = NO;
//
//
//    [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//        if (isSave) {
//
//            [YDDBTable db:db updateBraceletDayRecordWithModel:dayModel andDayNum:dayModel.dayNum andPeripheralUUID:dayModel.peripheralUUID];
//        }
//        else
//        {
//            [YDDBTable db:db insertBraceletDayRecordToDataBase:dayModel];
//        }
//
//        [YDDBTable db:db deleteBraceletSyncRecordFromDataBaseForSyncID:_syncModel.syncID];
//    } completHandler:^() {
//
//        _syncModel.isSave = YES;
//
//        NSUserDefaults *userdf =[NSUserDefaults standardUserDefaults];
//        NSNumber *firstDayNum = [userdf objectForKey:dayModel.peripheralUUID];
//        if (firstDayNum == nil) {
//            [userdf setObject:dayModel.dayNum forKey:dayModel.peripheralUUID];
//        }
//        else if(dayModel.dayNum.integerValue<firstDayNum.integerValue)
//        {
//            [userdf setObject:dayModel.dayNum forKey:dayModel.peripheralUUID];
//        }
//        NSLog(@"dayNum == %@",dayModel.dayNum);
//        [userdf setObject:[NSDate date] forKey:BRACELET_LAST_TIME];
//        if (completion) {
//            completion();
//        }
//    }];
//}



@end
