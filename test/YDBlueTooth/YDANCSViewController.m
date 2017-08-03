//
//  YDANCSViewController.m
//  test
//
//  Created by Aka on 2017/8/3.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDANCSViewController.h"
#import "YDBlueToothMgr.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface YDANCSViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) YDBlueToothMgr *btMgr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *peripherals;

@end


static NSString *const reuseCellId = @"tableview.cell.id";

@implementation YDANCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btMgr = [YDBlueToothMgr shared];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"开始扫描" style:UIBarButtonItemStylePlain target:self action:@selector(toAction:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) -64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCellId];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
}

- (void)toAction:(UIButton *)sender {
    NSLog(@"开始扫描");
    __weak typeof (self) wSelf = self;
//    SH09U
    _btMgr.deliverFilterType(YDBlueToothFilterTypeContain).deliverContainField(@"SH").startScan().scanCallBack = ^(NSArray<CBPeripheral *> *peripherals) {
        _peripherals = peripherals;
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf.tableView reloadData];
        });
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId forIndexPath:indexPath];
    CBPeripheral *peripheral = _peripherals[indexPath.row];
    cell.textLabel.text = peripheral.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof (self) wSelf = self;
    _btMgr.connectingPeripheralIndex(indexPath.row).connectionCallBack = ^(BOOL success) {
        if (success) {
            wSelf.btMgr.characteristicCallBack = ^(CBCharacteristic *c) {
                NSLog(@"characteristic : %@",c.UUID.UUIDString);
            };
        }
    };
}

@end
