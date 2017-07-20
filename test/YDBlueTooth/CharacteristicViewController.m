//
//  CharacteristicViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "CharacteristicViewController.h"
#import "YDBlueToothMgr.h"

@interface CharacteristicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YDBlueToothMgr *mgr;

@property (nonatomic, strong) UITableView *tableView;


@end

static NSString *const characteristicCellidentifierId = @"characteristic.cell.identifier.id";

@implementation CharacteristicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:characteristicCellidentifierId];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger cellNum = 5;
    return cellNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:characteristicCellidentifierId forIndexPath:indexPath];
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

@end
