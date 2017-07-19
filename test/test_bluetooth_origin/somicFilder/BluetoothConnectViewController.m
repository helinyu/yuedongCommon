//
//  BluetoothConnectViewController.m
//  SOMICS3
//
//  Created by mac-somic on 2017/4/21.
//  Copyright © 2017年 mac-somic. All rights reserved.
//

#import "BluetoothConnectViewController.h"
#import "S3Manager.h"
#import "SVProgressHUD.h"
#import "S3MainView.h"
#import "S3ActivityIndicatorView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface BluetoothConnectViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSTimer *_scanDeviceTimer;
}

@property (strong, nonatomic ) UITableView *bluetoothTableView;

@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;

@property (strong, nonatomic ) NSArray *nDevices;

@property (nonatomic, strong) S3ActivityIndicatorView *indicatoryView;

@end

@implementation BluetoothConnectViewController

- (instancetype)initBlueVCWithArray:(NSArray *)array{
    if (self = [super init]) {
        [_nDevices arrayByAddingObjectsFromArray:array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"连接蓝牙";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.bluetoothTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.bluetoothTableView.delegate = self;
    self.bluetoothTableView.dataSource = self;
    self.bluetoothTableView.rowHeight = 60;
    [self.view addSubview:self.bluetoothTableView];
    
    self.bluetoothTableView.contentOffset = CGPointMake(0, -64);
    self.bluetoothTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.indicatoryView = [[S3ActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.indicatoryView];
    self.indicatoryView.backgroundColor = [UIColor grayColor];
    self.indicatoryView.alpha = 0.6;
    
    if (self.nDevices.count <= 0) {
        [self.indicatoryView.indicatorView startAnimating];
    }
    
    _scanDeviceTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(act_observerDivices:) userInfo:nil repeats:true];
}

- (void)act_observerDivices:(NSTimer *)timer {
    self.nDevices = [S3Manager shareManager].nDevices;
    if (self.nDevices.count != 0) {
        if (self.indicatoryView) {
            if (self.indicatoryView.indicatorView.isAnimating) {
                [self.indicatoryView.indicatorView stopAnimating];
            }
            [self.indicatoryView removeFromSuperview];
        }
        [self.bluetoothTableView reloadData];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
  //  NSLog(@"view will disappear");
    [[S3Manager shareManager].manager stopScan];
    if (_scanDeviceTimer) {
        [_scanDeviceTimer invalidate];
        _scanDeviceTimer = nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_nDevices count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identified = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identified];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    CBPeripheral *p = [_nDevices objectAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _peripheral = [_nDevices objectAtIndex:indexPath.row];
    [S3Manager shareManager].peripheral = _peripheral;
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"已选择：%@",_peripheral.name]];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
