//
//  YDS3PeriipheralsViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDS3PeriipheralsViewController.h"
#import "YDBlueToothMgr.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "SVProgressHUD.h"

@interface YDS3PeriipheralsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YDBlueToothMgr *mgr;
@property (nonatomic, strong) NSArray<CBPeripheral *> *peripherals;

@end

static const NSInteger navBarH = 64.f;
static NSString *const peripheralsListCellIdentifierId = @"peripheral.lsit.cell.identifier.id";

@implementation YDS3PeriipheralsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navBarH, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) -navBarH) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:peripheralsListCellIdentifierId];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _mgr = [YDBlueToothMgr shared];
    __weak typeof (self) wSelf = self;
    _mgr.startScan().scanCallBack = ^(NSArray<CBPeripheral *> *peripherals) {
        wSelf.peripherals = peripherals;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:peripheralsListCellIdentifierId forIndexPath:indexPath];
    cell.textLabel.text = _peripherals[indexPath.row].name;
    return cell;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_mgr onConnectBluetoothWithIndex:indexPath.row];
    _mgr.connectionCallBack = ^(BOOL success) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showWithStatus:@"链接失败或者断开连接"];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
