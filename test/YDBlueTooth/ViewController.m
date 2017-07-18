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

#import "DisplayserviceViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<CBPeripheral *> *peripherals;


@end

static const CGFloat navBarH = 64.f;

static NSString *const reuseIdentifierId = @"reuser.identifier.id";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navBarH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - navBarH) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifierId];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    __weak typeof (self) wSelf = self;
    [YDBlueToothMgr shared].filterType = YDBlueToothFilterTypeContain;
    [YDBlueToothMgr shared].containField = @"S3";
    [YDBlueToothMgr shared].scanCallBack = ^(NSArray<CBPeripheral *> *peripherals) {
        _peripherals = peripherals;
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf.tableView reloadData];
        });
    };
    [[YDBlueToothMgr shared] startScan];
    
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierId forIndexPath:indexPath];
    CBPeripheral *item = _peripherals[indexPath.row];
    cell.textLabel.text = item.name;
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
    [[YDBlueToothMgr shared] onConnectBluetoothWithIndex:indexPath.row];
//    DisplayserviceViewController *vc = [DisplayserviceViewController new];
//    vc.mgr = [YDBlueToothMgr shared];
//    [self.navigationController pushViewController:vc animated:YES];
//    why is not the same mgr 
}

@end
