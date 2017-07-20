//
//  ServicesViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ServicesViewController.h"
#import "YDBlueToothMgr.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "CharacteristicViewController.h"

@interface ServicesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YDBlueToothMgr *mgr;  // 单例可能创建的地址是一样，可能状体发生了变化
@property (nonatomic, strong) NSArray<CBService *> *services;

@end

static NSString *const serviceCellIdentifierId = @"service.cell.identifier.id";

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:serviceCellIdentifierId];
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"vc mgr: %@",_mgr);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof (self) wSelf = self;
    _mgr.servicesCallBack = ^(NSArray<CBService *> *services) {
        NSLog(@"services : %@",services);
        wSelf.services = services;
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
    return _services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceCellIdentifierId forIndexPath:indexPath];
    CBService *item = _services[indexPath.row];
    cell.textLabel.text = item.UUID.UUIDString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"choise index");
    CharacteristicViewController *vc = [CharacteristicViewController new].deliverMgr(_mgr).deliverService(_services[indexPath.row]);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- custom methods

- (ServicesViewController *(^)(YDBlueToothMgr *paramMgr))vcMgr {
    return ^(YDBlueToothMgr *paramMgr) {
        _mgr = paramMgr;
        return self;
    };
}

@end
