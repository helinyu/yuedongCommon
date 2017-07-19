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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *peripherals;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
