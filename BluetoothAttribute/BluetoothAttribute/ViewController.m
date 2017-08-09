//
//  ViewController.m
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/7.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "YDDefine.h"
#import "YDPeripheralInfo.h"

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CBCentralManager *centralManger;
//@property (nonatomic, strong) NSMutableArray *peripherals;
@property (nonatomic, strong) CBPeripheral *selectedPeripheral;
@property (nonatomic, strong) NSArray *selectedPeripheralServices;
@property (nonatomic, strong) NSMutableArray<NSUUID *> *connectedPeripheralsdentifiers;
@property (nonatomic, strong) NSMutableArray<CBUUID *> *connectedservicesUUIDs;
@property (nonatomic, strong) CBUUID *discoverServiceUUID;

@property (nonatomic, strong) NSMutableArray<YDPeripheralInfo *> *peripheralInfos;

@end

static NSString *const resuserIdentifier = @"reuseIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 100) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:resuserIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
//    cbperipheral
//    _peripherals = @[].mutableCopy;
    _connectedPeripheralsdentifiers = @[].mutableCopy;
    _connectedservicesUUIDs = @[].mutableCopy;
    _discoverServiceUUID = [CBUUID UUIDWithString:@"0xFFF0"];
    _peripheralInfos = @[].mutableCopy;

//     这个方法是否可以去掉 设置这个属性，也是没有问题的，还是运行顺畅
    NSDictionary *centralInitOptions = @{CBCentralManagerOptionShowPowerAlertKey:@(YES),CBCentralManagerOptionRestoreIdentifierKey:@"restoreidentifier"};
    _centralManger = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(0, 0) options:centralInitOptions];
 
    [self UICreation];
}

#pragma mark -- ui components 

- (void)UICreation {
    UIButton *stopScanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopScanBtn setTitle:@"停止扫描" forState:UIControlStateNormal];
    stopScanBtn.frame = CGRectMake(10, 66, 80, 30);
    [stopScanBtn addTarget:self action:@selector(onStopScanClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopScanBtn];
    
    UIButton *cancelConnectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelConnectBtn setTitle:@"取消链接" forState:UIControlStateNormal];
    cancelConnectBtn.frame = CGRectMake(100, 66, 50, 30);
    [cancelConnectBtn addTarget:self action:@selector(onCancelConnectedClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelConnectBtn];
    
    UIButton *retrieveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [retrieveBtn setTitle:@"retrive peri" forState:UIControlStateNormal];
    [retrieveBtn addTarget:self action:@selector(onRetriveIdentifierClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retrieveBtn];
    retrieveBtn.frame = CGRectMake(160, 66, 100, 30);
    
    UIButton *serviceRetriveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [serviceRetriveBtn setTitle:@"retrive suuids" forState:UIControlStateNormal];
    [serviceRetriveBtn addTarget:self action:@selector(onRetriveServicesClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceRetriveBtn];
    serviceRetriveBtn.frame = CGRectMake(260, 66, 100, 30);

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

- (void)onStopScanClicked {
    [_centralManger stopScan];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _peripherals.count;
    return _peripheralInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuserIdentifier forIndexPath:indexPath];
//    CBPeripheral *peripheral = _peripherals[indexPath.row];
    YDPeripheralInfo *infoItem = _peripheralInfos[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@,%@",infoItem.peripheral.name,infoItem.RSSI];
//    cell.detailTextLabel.text = peripheral.identifier.UUIDString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath: %@",indexPath);
    [_centralManger stopScan];
    
    _selectedPeripheral = ((YDPeripheralInfo *)_peripheralInfos[indexPath.row]).peripheral;;
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@(YES),CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES),CBConnectPeripheralOptionNotifyOnNotificationKey:@(YES)};
    [_centralManger connectPeripheral:_selectedPeripheral options:connectOptions];
    
//    本地存储已经连接的uuid
    [[NSUserDefaults standardUserDefaults] setObject:_selectedPeripheral.identifier.UUIDString forKey:@"selectedPeripheralUUIDString"];
}

//central manager delegate
#pragma mark -- central manager 大体的
#pragma mark -- CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
//        options 的设置
//        NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)};
        [_centralManger scanForPeripheralsWithServices:nil options:nil];
    }else{
        NSLog(@"请打开蓝牙设备");
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {

    NSLog(@"peripheral name is ; %@",peripheral.name);
    if (peripheral.name.length <=0) {
        return ;
    }
    
//    if (_peripherals.count <= 0) {
//        [_peripherals addObject:peripheral];
//    }else{
//        BOOL hasStore = NO;
//        for (NSInteger index =0; index <_peripherals.count; index++) {
//            CBPeripheral *storePeripheral = _peripherals[index];
//            if ([storePeripheral.name isEqualToString:peripheral.name] && [storePeripheral.identifier isEqual:peripheral.identifier]) {
//                [_peripherals removeObject:storePeripheral];
//                [_peripherals insertObject:peripheral atIndex:index];
//                hasStore = YES;
//                break;
//            }
//        }
//        if (!hasStore) {
//            [_peripherals addObject:peripheral];
//        }
//    }
    
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}

//存储了上一次已经连接的内容,存储了之后需要怎么进行处理？
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
//    NSLog(@"central : %@",central);
    NSLog(@"dict : %@",dict);
    
//    这个是一种可能，重新扫描外
    NSDictionary *scanOptions = dict[CBCentralManagerRestoredStateScanOptionsKey];
    if (_centralManger.state != CBManagerStatePoweredOn) {
        _centralManger = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(0, 0) options:scanOptions];
    }

//    这个是一种可能，重新扫描服务 （这个时候应该是连接了，但是没有扫描服务，这个应该怎么样去区分）
//    这里的option似乎并没有存储  ？？？
    NSArray *serviceUUIDs = dict[CBCentralManagerRestoredStateScanServicesKey];
    NSDictionary *serivceOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)};
    [_centralManger scanForPeripheralsWithServices:serviceUUIDs options:serivceOptions];
    
//    进行连接 ，在有服务的时候并且设备已经找到了，需要进行连接
    NSArray *storePeripherals = dict[CBCentralManagerRestoredStatePeripheralsKey];
    [storePeripherals enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CBPeripheral *peripheral = (CBPeripheral *)obj;
//        这里不应该是链接（因为现在已经连接了）
//        [_connectedPeripheralsdentifiers addObject:peripheral.identifier];
        [_centralManger cancelPeripheralConnection:peripheral];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"selectedPeripheralUUIDString"];
    }];
}

//一切读取数据的开始（） 【 输入 ---> 输出 】
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"did connect peripheral name : %@ , identifier : %@",peripheral.name,peripheral.identifier);
    //    store the peripehral identifier which has connencted
    [_connectedPeripheralsdentifiers addObject:peripheral.identifier];
    
//这里肯定是单一的内容
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"fail to connnect");
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"did disconnect peripheral : %@",error);
    [_connectedPeripheralsdentifiers removeObject:peripheral.identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    NSLog(@"diddiscover peripheral  name:%@, services : %@",peripheral.name,peripheral.services);
    [peripheral.services enumerateObjectsUsingBlock:^(CBService * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CBService *service = ((CBService *)obj);
        if ([service.UUID isEqual:_discoverServiceUUID]) {
            [_connectedservicesUUIDs addObject:service.UUID];
            //        discover characteristic
            [peripheral discoverCharacteristics:nil forService:service];
        }
        
//没有discover之前都是为nil的
//        NSArray *characteristics = service.characteristics;
//        [characteristics enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            CBCharacteristic *c = (CBCharacteristic *)obj;
//            NSLog(@"characteristic : %@",c);
//        }];
    }];
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
//        if ([obj.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]) {
////            0x72
//            Byte bytes[] ={0x72};
//            NSData *datas = [[NSData alloc] initWithBytes:bytes length:1];
//            [peripheral writeValue:datas forCharacteristic:obj type:CBCharacteristicWriteWithResponse];
//        }else if([obj.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
//            [peripheral setNotifyValue:YES forCharacteristic:obj];
//        }else if([obj.UUID isEqual:[CBUUID UUIDWithString:@"FFF3"]]) {
//            [peripheral setNotifyValue:YES forCharacteristic:obj];
//        }else{
//
//        }
    
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

//L2CAP这个的作用
//- (void)peripheral:(CBPeripheral *)peripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel *)channel error:(nullable NSError *)error {
//}

@end
