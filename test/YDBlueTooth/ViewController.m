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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<CBPeripheral *> *peripherals;
@property (nonatomic, strong) YDBlueToothMgr *mgr;
@property (nonatomic, strong) NSArray<CBService *> *services;

@end

static const CGFloat navBarH = 64.f;

static NSString *const reuseCellIdentifierId = @"reuser.cell.identifier.id";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navBarH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - navBarH) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCellIdentifierId];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [SVProgressHUD showInfoWithStatus:@"准备打开设备"];
    NSLog(@"view did load");

    _mgr = [YDBlueToothMgr shared];
    _mgr.prefixField = @"s3";
    _mgr.filterType = YDBlueToothFilterTypePrefix;
    [_mgr startScan];
    __weak typeof (self) wSelf = self;
    _mgr.scanCallBack = ^(NSArray<CBPeripheral *> *peripherals) {
        _peripherals = peripherals;
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf.tableView reloadData];
        });
    };
    
}


#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIdentifierId forIndexPath:indexPath];
    cell.textLabel.text = _peripherals[indexPath.row].name;
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
    [_mgr onConnectBluetoothWithIndex:indexPath.row];
    __weak typeof (self) wSelf = self;
    _mgr.servicesCallBack = ^(NSArray<CBService *> *services) {
        _services = services;
        [wSelf logServicesInfoWithSerivces:services];
    };
}

- (void)logServicesInfoWithSerivces:(NSArray <CBService *> *)services {
    for (CBService *item in services) {
        NSLog(@"service : %@",item.UUID);
    }
}

@end
