//
//  ViewController.m
//  test_yuedong_band
//
//  Created by Aka on 2017/8/17.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "YDBluetoothWebViewMgr.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "YDDefine.h"
#import "YDMainContentViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *peripherals;

@property (nonatomic, strong) YDBluetoothWebViewMgr *btMgr;

@end

static NSString *const resuserIdentifierCellId = @"reuser.identifier.cell.id";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _btMgr = [YDBluetoothWebViewMgr shared];
    _peripherals = @[].mutableCopy;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100,CGRectGetWidth([UIScreen mainScreen].bounds),CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:resuserIdentifierCellId];
    _tableView.dataSource  = self;
    _tableView.delegate = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"开始扫描" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onScanClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 64, 100, 30);
}

- (void)onScanClick {
    __weak typeof (self) wSelf = self;
    [_btMgr scanPeripheralWithMatchInfo:@{@"YDBlueToothFilterType":@(YDBlueToothFilterTypePrefix),@"prefixField":@"RUN"}];
    [_btMgr startScanThenNewPeripheralCallback:^(CBPeripheral *peripheral) {
        [wSelf.peripherals addObject:peripheral];
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf.tableView reloadData];
        });
    }];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuserIdentifierCellId forIndexPath:indexPath];
    CBPeripheral *peripheral = _peripherals[indexPath.row];
    cell.textLabel.text = peripheral.name;
    cell.detailTextLabel.text = peripheral.identifier.UUIDString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *choicePeralpheral = _peripherals[indexPath.row];    
    YDMainContentViewController *vc = [YDMainContentViewController new];
    vc.choicePeripheral = choicePeralpheral;
    vc.mgr = _btMgr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
