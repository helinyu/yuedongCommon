//
//  ViewController.m
//  MyselfDemo
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 刘彦玮. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Layout.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"
#import "SVProgressHUD.h"
#import "DisplayPeripheralViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *peripherals;

@property (nonatomic, strong) BabyBluetooth *bluetooth;

@end

static NSString *const kBluetoothListCellId = @"k.bluetooth.list.cell.id";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kBluetoothListCellId];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    _peripherals = [NSMutableArray new];
    
    _bluetooth = [BabyBluetooth shareBabyBluetooth];
    [self babyBluetoothDelegate];
}

- (void)viewDidAppear:(BOOL)animated {
    [_bluetooth cancelAllPeripheralsConnection];
    _bluetooth.scanForPeripherals().begin();
}

#pragma mark --baby bluetooth delegate

- (void)babyBluetoothDelegate {
    
    __weak typeof (self) wSelf = self;
    
//    查看蓝牙的开关状态 （也就是检测蓝牙的硬件状态）
    [_bluetooth setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            NSLog(@"硬件状态是开的");
            [SVProgressHUD showInfoWithStatus:@"硬件状态是开的"];
        }
    }];
 
//    设置过滤条件
    [_bluetooth setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        if (peripheralName.length > 0) {
            return YES;
        }
        return NO;
    }];

//    找到设备的地代理
    [_bluetooth setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        [wSelf.peripherals addObject:peripheral];
        [wSelf.tableView reloadData];
    }];

    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@NO};
    [_bluetooth setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBluetoothListCellId forIndexPath:indexPath];
    CBPeripheral *item = _peripherals[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_bluetooth cancelScan];
    DisplayPeripheralViewController *vc = [DisplayPeripheralViewController new];
    vc.blueTooth = _bluetooth;
    vc.currPeripheral = _peripherals[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
