//
//  ViewController.m
//  test_babyBlueTooth
//
//  Created by Aka on 2017/7/5.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
//#import <GameKit/GameKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CBCentralManager *centralManger;

@property (nonatomic, strong) NSMutableArray<CBPeripheral *> *peripherals;

@end

static NSString *const reuseIdentifier = @"re.use.identifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"蓝牙";
    self.view.backgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor greenColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _peripherals = [NSMutableArray<CBPeripheral *> new];
    _centralManger = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
}

#pragma mark -- central manager delegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.f) {
        switch (central.state) {
            case CBManagerStateUnknown:
                break;
            case CBManagerStateResetting:
                
                break;
            case CBManagerStateUnsupported:
                
                break;
            case CBManagerStateUnauthorized:
                
                break;
            case CBManagerStatePoweredOff:
                [self centralMangerPowerOffWithCentral:central];
                break;
            case CBManagerStatePoweredOn:
            {
                [self scanPerialsWithCentral:central];
            }
                break;
            default:
                break;
        }
    }else{
        switch (central.state) {
            case CBCentralManagerStateUnknown:
                
                break;
            case CBCentralManagerStateResetting:
                
                break;
            case CBCentralManagerStateUnsupported:
                
                break;
            case CBCentralManagerStateUnauthorized:
                
                break;
            case CBCentralManagerStatePoweredOff:
                [self centralMangerPowerOffWithCentral:central];
                break;
            case CBCentralManagerStatePoweredOn:
            {
                [self scanPerialsWithCentral:central];
            }
                break;
            default:
                break;
        }
    }
}

- (void)centralMangerPowerOffWithCentral:(CBCentralManager *)central {
    NSLog(@"请在设置中打开蓝牙，");
}

- (void)scanPerialsWithCentral:(CBCentralManager *)central {
    if([UIDevice currentDevice].systemVersion.floatValue >= 9.f) {
        if (!central.isScanning) {
            [central scanForPeripheralsWithServices:nil options:nil];
        }
    }else{
        [central scanForPeripheralsWithServices:nil options:nil];
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

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"peripheral name : %@,identifier : %@",peripheral.name,peripheral.identifier.UUIDString);
    BOOL flag = NO;
    for (CBPeripheral *item in _peripherals) {
        if ([item.identifier isEqual:peripheral.identifier]) {
            flag = YES;
            break;
        }
    }
    if (!flag) {
        [_peripherals addObject:peripheral];
        [_tableView reloadData];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
//    NSLog(@"peripheral state: %d : name=%@, identfifier : %@",peripheral.state,peripheral.name,peripheral.identifier.UUIDString);
    NSLog(@"peripheral state: %ld",(long)peripheral.state);
//    CBPeripheralStateDisconnected = 0,
//    CBPeripheralStateConnecting,
//    CBPeripheralStateConnected,
//    CBPeripheralStateDisconnecting NS_AVAILABLE(NA, 9_0),
    peripheral.delegate = self;
    [_centralManger stopScan];
    
    [peripheral discoverServices:nil];
//    [peripheral readRSSI];
//    [peripheral discoverIncludedServices:nil forService:[CBService new]];
//    [peripheral discoverDescriptorsForCharacteristic:[CBCharacteristic new]];
//    [peripheral discoverCharacteristics:nil forService:[CBService new]];
//    [peripheral readValueForDescriptor:[CBDescriptor new]];
//    [peripheral readValueForCharacteristic:[CBCharacteristic new]];
//  NSInteger maxNum = [peripheral maximumWriteValueLengthForType:CBCharacteristicWriteWithoutResponse];
//    - (void)writeValue:(NSData *)data forCharacteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type;
//    - (void)writeValue:(NSData *)data forCharacteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type;
//    - (void)setNotifyValue:(BOOL)enabled forCharacteristic:(CBCharacteristic *)characteristic;
//    - (void)discoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic;
//    - (void)readValueForDescriptor:(CBDescriptor *)descriptor;
//    - (void)writeValue:(NSData *)data forDescriptor:(CBDescriptor *)descriptor;
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSAssert(!error ,@"didFailToConnectPeripheral ");
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"didDisconnectPeripheral:name=%@,identifier=%@",peripheral.name,peripheral.identifier.UUIDString);
    //停止扫描
    [_centralManger stopScan];
    //断开连接
    [_centralManger cancelPeripheralConnection:peripheral];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    CBPeripheral *peripheral = _peripherals[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%@",peripheral.name,peripheral.identifier.UUIDString];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"_peripherals.count:%d",_peripherals.count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_centralManger connectPeripheral:_peripherals[indexPath.row] options:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -- peripheral delelgate

/*!
 *  @method peripheralDidUpdateName:
 *
 *  @param peripheral	The peripheral providing this update.
 *
 *  @discussion			This method is invoked when the @link name @/link of <i>peripheral</i> changes.
 */
- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral NS_AVAILABLE(NA, 6_0) {
    
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
    NSLog(@"rssi is : %@",RSSI);
}

/*!
 *  @method peripheral:didDiscoverServices:
 *
 *  @param peripheral	The peripheral providing this information.
 *	@param error		If an error occurred, the cause of the failure.
 *
 *  @discussion			This method returns the result of a @link discoverServices: @/link call. If the service(s) were read successfully, they can be retrieved via
 *						<i>peripheral</i>'s @link services @/link property.
 *
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"scan service : %@",peripheral.services);
    if (error) {
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"%@",service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法  -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [peripheral discoverCharacteristics:nil forService:service];
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
    if (error) {
        NSLog(@"did discver characteristics for service is error : %@",error);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
    }
    
    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        {
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
    
    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
    
    NSLog(@"service is : ");
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
    NSLog(@"didUpdateValueForCharacteristic: serivce=%@,property=%lu",characteristic.service,(unsigned long)characteristic.properties);
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
    NSLog(@"didDiscoverDescriptorsForCharacteristic: service=%@,properties=%lu, uuid=%@",characteristic.service,(unsigned long)characteristic.properties,characteristic.UUID);
    for (CBDescriptor *descri in characteristic.descriptors) {
        NSLog(@"drscriptor uuid : %@",descri.UUID);
    }
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
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
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

@end
