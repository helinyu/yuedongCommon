//
//  DisplayPeripheralViewController.m
//  MyselfDemo
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 刘彦玮. All rights reserved.
//

#import "DisplayPeripheralViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"
#import "SVProgressHUD.h"
#import "PeripheralInfo.h"
#import "DisplayCharacteristicViewController.h"

@interface DisplayPeripheralViewController ()<UITableViewDataSource,UITabBarDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const kDisplayPeripheralCellId = @"display.peripheral.cell.id";
static NSString *const testInfoChannel = @"testInfoChannel";

@implementation DisplayPeripheralViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDisplayPeripheralCellId];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _services = [NSMutableArray new];
    [self babyDelegate];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:2.f];
    [SVProgressHUD showInfoWithStatus:@"准备连接设备"];
}

#pragma mark -- bluetooth delegate block

- (void)babyDelegate {
    __weak typeof (self) wSelf = self;
    
    [_blueTooth setBlockOnConnectedAtChannel:testInfoChannel block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        NSLog(@"setBlockOnConnectedAtChannel");
    }];
    
    [_blueTooth setBlockOnFailToConnectAtChannel:testInfoChannel block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"setBlockOnFailToConnectAtChannel");

    }];
    
    [_blueTooth setBlockOnDisconnectAtChannel:testInfoChannel block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"setBlockOnDisconnectAtChannel");
    }];
    
    [_blueTooth setBlockOnDiscoverServicesAtChannel:testInfoChannel block:^(CBPeripheral *peripheral, NSError *error) {
        NSLog(@"setBlockOnDiscoverServicesAtChannel");
        
        [self configureServicesWithServices:peripheral.services];

    }];
    
    [_blueTooth setBlockOnDiscoverCharacteristicsAtChannel:testInfoChannel block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"setBlockOnDiscoverCharacteristicsAtChannel");
//     有关的内容处理
        [wSelf configureCharacteristicsWithService:service];
    }];
    
    [_blueTooth setBlockOnReadValueForCharacteristicAtChannel:testInfoChannel block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"setBlockOnReadValueForCharacteristicAtChannel");
    }];
    
    [_blueTooth setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:testInfoChannel block:^(CBPeripheral *peripheral, CBCharacteristic *service, NSError *error) {
        NSLog(@"setBlockOnDiscoverDescriptorsForCharacteristicAtChannel");
    }];

    [_blueTooth setBlockOnReadValueForDescriptorsAtChannel:testInfoChannel block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"setBlockOnReadValueForDescriptorsAtChannel");
    }];
    
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@NO};
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnNotificationKey:@YES};
    [_blueTooth setBabyOptionsAtChannel:testInfoChannel scanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
}

#pragma mark -- custom methods

- (void)loadData {
    [SVProgressHUD showInfoWithStatus:@"开始连接设备"];
_blueTooth.having(_currPeripheral).channel(testInfoChannel).connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

#pragma mark -- tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _services.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PeripheralInfo *info = [_services objectAtIndex:section];
    return [info.characteristics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDisplayPeripheralCellId forIndexPath:indexPath];
    CBCharacteristic *characteristic = [[[self.services objectAtIndex:indexPath.section] characteristics]objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",characteristic.UUID];
    cell.detailTextLabel.text = characteristic.description;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    PeripheralInfo *info = [self.services objectAtIndex:section];
    title.text = [NSString stringWithFormat:@"%@", info.serviceUUID];
    [title setTextColor:[UIColor whiteColor]];
    [title setBackgroundColor:[UIColor darkGrayColor]];
    return title;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DisplayCharacteristicViewController *vc = [[DisplayCharacteristicViewController alloc]init];
    vc.currPeripheral = self.currPeripheral;
    vc.characteristic =[[[self.services objectAtIndex:indexPath.section] characteristics]objectAtIndex:indexPath.row];
    vc.bluetooth = _blueTooth;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)configureServicesWithServices:(NSArray<CBService *> *)services {
    for (CBService *service in services) {
        PeripheralInfo *info = [[PeripheralInfo alloc]init];
        info.serviceUUID = service.UUID;
        [_services addObject:info];
    }
    [_tableView reloadData];
}

-(void)configureCharacteristicsWithService:(CBService *)service{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    int sect = -1;
    for (int i=0;i<self.services.count;i++) {
        PeripheralInfo *info = [self.services objectAtIndex:i];
        if (info.serviceUUID == service.UUID) {
            sect = i;
        }
    }
    
    if (sect != -1) {
        PeripheralInfo *info =[self.services objectAtIndex:sect];
        for (int row=0;row<service.characteristics.count;row++) {
            CBCharacteristic *c = service.characteristics[row];
            [info.characteristics addObject:c];
        }
        PeripheralInfo *curInfo =[self.services objectAtIndex:sect];
        NSLog(@"%@",curInfo.characteristics);
    }
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
