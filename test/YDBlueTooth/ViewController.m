//
//  ViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "YDBlueToothMgr.h"
#import "UIView+Layout.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"
#import "SVProgressHUD.h"

#import "DisplayserviceViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *peripheralDataArray;
    BabyBluetooth *baby;
}

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSArray<CBPeripheral *> *peripherals;

//@property (nonatomic,strong, readwrite) BabyBluetooth *baby;


@end

static const CGFloat navBarH = 64.f;

static NSString *const reuseIdentifierId = @"reuser.identifier.id";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    peripheralDataArray = [NSMutableArray new];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navBarH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - navBarH) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifierId];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [SVProgressHUD showInfoWithStatus:@"准备打开设备"];
    NSLog(@"view did load");
//    [baby cancelAllPeripheralsConnection];
//    设置蓝牙代理
    baby = [BabyBluetooth shareBabyBluetooth];
    [self babyDelegate];
}

- (void)viewDidAppear:(BOOL)animated {
    //停止之前的连接
    [baby cancelAllPeripheralsConnection];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
    baby.scanForPeripherals().begin();

}

- (void)babyDelegate {
    
    __weak typeof(self) weakSelf = self;

    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
//    baby.scanForPeripherals().begin();
    
    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            [SVProgressHUD showInfoWithStatus:@"设备打开成功，开始扫描设备"];
        }
    }];
    
//    设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜到到设备的名字是: %@",peripheral.name);
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
    
    
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
        }
    }];
    
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        //最常用的场景是查找某一个前缀开头的设备
        //        if ([peripheralName hasPrefix:@"Pxxxx"] ) {
        //            return YES;
        //        }
        //        return NO;
        
        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
        if (peripheralName.length >0) {
            return YES;
        }
        return NO;
    }];
    
    
    [baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
    }];
    
    [baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelScanBlock");
    }];
    
    
    /*设置babyOptions
     
     参数分别使用在下面这几个地方，若不使用参数则传nil
     - [centralManager scanForPeripheralsWithServices:scanForPeripheralsWithServices options:scanForPeripheralsWithOptions];
     - [centralManager connectPeripheral:peripheral options:connectPeripheralWithOptions];
     - [peripheral discoverServices:discoverWithServices];
     - [peripheral discoverCharacteristics:discoverWithCharacteristics forService:service];
     
     该方法支持channel版本:
     [baby setBabyOptionsAtChannel:<#(NSString *)#> scanForPeripheralsWithOptions:<#(NSDictionary *)#> connectPeripheralWithOptions:<#(NSDictionary *)#> scanForPeripheralsWithServices:<#(NSArray *)#> discoverWithServices:<#(NSArray *)#> discoverWithCharacteristics:<#(NSArray *)#>]
     */
    
    //示例:
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    //连接设备->
    [baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
}

#pragma mark -- custom insert datas 

-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSArray *peripherals = [peripheralDataArray valueForKey:@"peripheral"];
    if(![peripherals containsObject:peripheral]) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:peripheral forKey:@"peripheral"];
        [item setValue:RSSI forKey:@"RSSI"];
        [item setValue:advertisementData forKey:@"advertisementData"];
        [peripheralDataArray addObject:item];
        
//        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
    
}


#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return peripheralDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierId forIndexPath:indexPath];
//    CBPeripheral *item = peripheralDataArray[indexPath.row];
//    cell.textLabel.text = item.name;
//    return cell;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    NSDictionary *advertisementData = [item objectForKey:@"advertisementData"];
    NSNumber *RSSI = [item objectForKey:@"RSSI"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //peripheral的显示名称,优先用kCBAdvDataLocalName的定义，若没有再使用peripheral name
    NSString *peripheralName;
    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
        peripheralName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
    }else if(!([peripheral.name isEqualToString:@""] || peripheral.name == nil)){
        peripheralName = peripheral.name;
    }else{
        peripheralName = [peripheral.identifier UUIDString];
    }
    
    cell.textLabel.text = peripheralName;
    //信号和服务
    cell.detailTextLabel.text = [NSString stringWithFormat:@"RSSI:%@",RSSI];
    
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellH = 60.f;
    return cellH;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [[YDBlueToothMgr shared] onConnectBluetoothWithIndex:indexPath.row];
//    DisplayserviceViewController *vc = [DisplayserviceViewController new];
//    vc.mgr = [YDBlueToothMgr shared];
//    [self.navigationController pushViewController:vc animated:YES];
//    why is not the same mgr
    
    [baby cancelScan];
    
    DisplayserviceViewController *vc = [[DisplayserviceViewController alloc]init];
    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    vc.currPeripheral = peripheral;
    vc->baby = self->baby;
    [self.navigationController pushViewController:vc animated:YES];

}

@end
