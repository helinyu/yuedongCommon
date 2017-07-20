//
//  CharacteristicViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "CharacteristicViewController.h"
#import "YDBlueToothMgr.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "Masonry.h"


@interface CharacteristicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YDBlueToothMgr *mgr;

@property (nonatomic, strong) CBService *currentService;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *runNum;
@property (nonatomic, strong) UILabel *runNumValue;
@property (nonatomic, strong) UILabel *heartRateNum;
@property (nonatomic, strong) UILabel *heartRateNumValue;
@property (nonatomic, strong) UILabel *sleepNum;
@property (nonatomic, strong) UILabel *sleepNumValue;

@end

static NSString *const characteristicCellidentifierId = @"characteristic.cell.identifier.id";

@implementation CharacteristicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth([UIScreen mainScreen].bounds),CGRectGetHeight([UIScreen mainScreen].bounds) -200) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:characteristicCellidentifierId];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _runNum = [UILabel new];
    [self.view addSubview:_runNum];
    _runNum.text = [NSString stringWithFormat:@"步数:%d",0];
    [_runNum sizeToFit];
    [_runNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(64);
    }];
    
    
    _heartRateNum = [UILabel new];
    [self.view addSubview:_heartRateNum];
    _heartRateNum.text = [NSString stringWithFormat:@"心率:%d",0];
    [_heartRateNum sizeToFit];
    [_heartRateNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(64);
    }];
    
    _sleepNum = [UILabel new];
    [self.view addSubview:_sleepNum];
    _sleepNum.text = [NSString stringWithFormat:@"睡眠:%d",0];
    [_sleepNum sizeToFit];
    [_sleepNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.centerX.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _currentService.characteristics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:characteristicCellidentifierId forIndexPath:indexPath];
    CBCharacteristic *chara = _currentService.characteristics[indexPath.row];
    cell.textLabel.text = chara.UUID.UUIDString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark -- some block

- (CharacteristicViewController *(^)(YDBlueToothMgr *mgr))deliverMgr {
    __weak typeof (self) wSelf = self;
    return ^(YDBlueToothMgr *mgr){
        wSelf.mgr = mgr;
        return self;
    };
}

- (CharacteristicViewController *(^)(CBService *service))deliverService {
    __weak typeof (self) wSelf = self;
    return ^(CBService *service){
        wSelf.currentService = service;
        return self;
    };
}

@end
