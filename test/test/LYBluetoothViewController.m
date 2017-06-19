//
//  LYBluetoothViewController.m
//  test
//
//  Created by felix on 2017/5/24.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "LYBluetoothViewController.h"
#import "Masonry.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface LYBluetoothViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) NSMutableArray *peripherals;

@property (weak, nonatomic) UISwitch *connectSwitch;


@end

@implementation LYBluetoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initCom];
    [self intiBind];
    
}

- (void)initCom {
    self.view.backgroundColor = [UIColor grayColor];
    self.title = NSLocalizedString(@"蓝牙测试", nil);
    
    UISwitch * connectSwitch = [UISwitch new];
    [self.view addSubview:connectSwitch];
    self.connectSwitch = connectSwitch;
    [connectSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
}

- (void)intiBind {
    [self.connectSwitch addTarget:self action:@selector(act_connectSwitchState:) forControlEvents:UIControlEventValueChanged];

}

#pragma mark - custom function
- (void)act_connectSwitchState:(UISwitch *)sender {
    
    NSLog(@"%d",sender.on);
    
    if (sender.on) {
        self.peripherals = [NSMutableArray new];
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }else{
        if ([self.centralManager isScanning]) {
            [self.centralManager stopScan];
        }
        [self.centralManager cancelPeripheralConnection:[self.peripherals lastObject]];
    }
    
}

#pragma mark -- CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSLog(@"central is : %ld",(long)central.state);
    switch (central.state) {
        case CBManagerStateUnknown:
        {
            break;
        }
        case CBManagerStateResetting:
        {
            break;
        }
        case CBManagerStateUnsupported:
        {
            break;
        }
        case CBManagerStateUnauthorized:
        {
            break;
        }
        case CBManagerStatePoweredOff:
        {
            break;
        }
        case CBManagerStatePoweredOn:
        {
            if (!self.centralManager.isScanning) {
                [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            }
            break;
        }
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    NSLog(@"willRestoreState");
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    [self.peripherals addObject:peripheral];
    NSLog(@"didDiscoverPeripheral");
    if ([peripheral.name containsString:@"S8"]) {
        NSLog(@"peripheral state : %ld",(long)peripheral.state);
        [central connectPeripheral:peripheral options:nil];
    }
}

//链接的情况
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"peripheral state : %ld",(long)peripheral.state);
    [self.centralManager stopScan];
    
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
//    已经链接了
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"didFailToConnectPeripheral");
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"didDisconnectPeripheral");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"did discover services ");
    if (error) {
        NSLog(@"error");
        return;
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"service : %@",service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral NS_AVAILABLE(NA, 6_0) {
    NSLog(@"peripheral name : %@",peripheral.name);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"did discover delegate ");
    
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
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

}

//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
    
}

//搜索到Characteristic的Descriptors
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    NSLog(@"characteristic uuid:%@",characteristic.UUID);
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor uuid:%@",d.UUID);
    }
    
}
//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}

//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{
    
      NSLog(@"%lu", (unsigned long)characteristic.properties);
    
    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }else{
        NSLog(@"该字段不可写！");
    }
    
    
}

@end
