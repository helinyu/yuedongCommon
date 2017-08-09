//
//  ViewController.m
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/7.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "YDBandViewController.h"
#import "YDBluetoothMgr.h"
#import "YDPeripheralInfo.h"
#import "YDConstant.h"

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YDBluetoothMgr *btMgr;
@property (nonatomic, strong) NSArray *peripheralInfos;
@property (nonatomic, strong) CBCentralManager *centralManger;

@end

static NSString *const resuserIdentifier = @"reuseIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBluetooth];
    [self UICreation];
    [self registerNotification];
 
}

#pragma mark -- ui components

- (void)loadBluetooth {
    _btMgr = YDBluetoothMgr.shared().loadBase().initCentralManager().scanPeripherals();
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReloadTables) name:YDPerppheralNeedReload object:nil];
}

- (void)onReloadTables {
    _peripheralInfos = _btMgr.peripheralInfos;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}

- (void)UICreation {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 100) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:resuserIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    UIButton *stopScanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopScanBtn setTitle:@"停止扫描" forState:UIControlStateNormal];
    stopScanBtn.frame = CGRectMake(10, 66, 80, 30);
    [stopScanBtn addTarget:_btMgr action:@selector(onStopScanClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopScanBtn];
    
    UIButton *cancelConnectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelConnectBtn setTitle:@"取消链接" forState:UIControlStateNormal];
    cancelConnectBtn.frame = CGRectMake(100, 66, 50, 30);
    [cancelConnectBtn addTarget:_btMgr action:@selector(onCancelConnectedClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelConnectBtn];
    
    UIButton *retrieveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [retrieveBtn setTitle:@"retrive peri" forState:UIControlStateNormal];
    [retrieveBtn addTarget:_btMgr action:@selector(onRetriveIdentifierClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retrieveBtn];
    retrieveBtn.frame = CGRectMake(160, 66, 100, 30);
    
    UIButton *serviceRetriveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [serviceRetriveBtn setTitle:@"retrive suuids" forState:UIControlStateNormal];
    [serviceRetriveBtn addTarget:_btMgr action:@selector(onRetriveServicesClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceRetriveBtn];
    serviceRetriveBtn.frame = CGRectMake(260, 66, 100, 30);

}

- (void)onStopScanClicked {
    [_centralManger stopScan];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _peripherals.count;
    return _peripheralInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuserIdentifier forIndexPath:indexPath];
    YDPeripheralInfo *infoItem = _peripheralInfos[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@,%@",infoItem.peripheral.name,infoItem.RSSI];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath: %@",indexPath);
    _btMgr.stopScanPeripheral().selectedPeriphealWithIndex(indexPath.row).startConnectSelectedPeripheral(nil).connectionStateBlock = ^(ConnectionState state) {
        if (state == ConnectionStateSuccess) {
            YDBandViewController *vc = [YDBandViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSLog(@"connect failure");
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
