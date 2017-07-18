//
//  DisplayserviceViewController.m
//  test
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "DisplayserviceViewController.h"
#import "YDBlueToothMgr.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface DisplayserviceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<CBService *> *services;

@end

static NSString *const displayCellIdentifierId = @"display.cell.identifier.id";

@implementation DisplayserviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:displayCellIdentifierId];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    __weak typeof (self) wSelf = self;
    _mgr.servicesCallBack = ^(NSArray<CBService *> *services) {
        _services = services;
        [wSelf.tableView reloadData];
    };
    
    NSLog(@"service count : %d",_services.count);
}


#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:displayCellIdentifierId forIndexPath:indexPath];
    cell.textLabel.text = _services[indexPath.row].UUID.UUIDString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
