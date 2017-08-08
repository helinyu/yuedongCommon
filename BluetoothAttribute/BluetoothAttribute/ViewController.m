//
//  ViewController.m
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/7.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *peripherals;

@property (nonatomic, strong) CBCentralManager *centralManger;

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
    _peripherals = @[].mutableCopy;
    
//     这个方法是否可以去掉 设置这个属性，也是没有问题的，还是运行顺畅
    NSDictionary *centralInitOptions = @{CBCentralManagerOptionShowPowerAlertKey:@(YES),CBCentralManagerOptionRestoreIdentifierKey:@"restoreidentifier"};
    _centralManger = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(0, 0) options:centralInitOptions];
 
    [self UICreation];
}

#pragma mark -- ui components 

- (void)UICreation {
    UIButton *stopScanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopScanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    stopScanBtn.frame = CGRectMake(20, 66, 50, 30);
    [stopScanBtn addTarget:self action:@selector(onStopScanClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopScanBtn];
    
    UIButton *connectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [connectBtn setTitle:@"转场" forState:UIControlStateNormal];
    connectBtn.frame = CGRectMake(80, 66, 50, 30);
    [connectBtn addTarget:self action:@selector(onConnectClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:connectBtn];

}

- (void)onConnectClicked {
    
}

- (void)onStopScanClicked {
    [_centralManger stopScan];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuserIdentifier forIndexPath:indexPath];
    CBPeripheral *peripheral = _peripherals[indexPath.row];
    cell.textLabel.text = peripheral.name;
    cell.detailTextLabel.text = peripheral.identifier.UUIDString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath: %@",indexPath);
    CBPeripheral *choicePeripheral = _peripherals[indexPath.row];
//    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@(YES),CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES),CBConnectPeripheralOptionNotifyOnNotificationKey:@(YES)};
    [_centralManger connectPeripheral:choicePeripheral options:nil];
}

//central manager delegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
//        options 的设置
        NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)};
        [_centralManger scanForPeripheralsWithServices:nil options:options];
    }else{
        NSLog(@"请打开蓝牙设备");
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
//    NSLog(@"central : %@",central);
//    NSLog(@"peripheral : %@",peripheral);
//    NSLog(@"advertisementdata is : %@",advertisementData);
//    NSLog(@"rssI : %@",RSSI);
    NSLog(@"peripherals : %@",_peripherals);
    [_peripherals addObject:peripheral];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
    
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    NSLog(@"central : %@",central);
    NSLog(@"dict : %@",dict);
    
//    这个是一种可能，重新扫描外设
    NSDictionary *scanOptions = dict[CBCentralManagerRestoredStateScanOptionsKey];
    if (!_centralManger) {
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
        [_centralManger connectPeripheral:peripheral options:nil];
    }];
}

#pragma mark -- central manager delegate

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"did connect peripheral name : %@ , identifier : %@",peripheral.name,peripheral.identifier);
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"fail to connnect");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
