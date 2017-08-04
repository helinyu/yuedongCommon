//
//  YDTrancenceViewController.m
//  test
//
//  Created by Aka on 2017/7/28.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDTrancenceViewController.h"
#import "YDBlueToothMgr.h"

@interface YDTrancenceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *scanBtn;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YDBlueToothMgr *mgr;

@end

@implementation YDTrancenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseUIkit];

    [self configureBaseInfo];


}

- (void)configureBaseInfo {
    _mgr = [YDBlueToothMgr shared];
    
    
}

- (void)loadBaseUIkit {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_scanBtn];
    [_scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    [_scanBtn addTarget:self action:@selector(onScanClicked) forControlEvents:UIControlEventTouchUpInside];
 
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
}

- (void)onScanClicked {
    _mgr.deliverFilterType(YDBlueToothFilterTypeContain).deliverContainField(@"trance");
    _mgr.startScan().scanCallBack = ^(NSArray<CBPeripheral *> *peripherals) {
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
