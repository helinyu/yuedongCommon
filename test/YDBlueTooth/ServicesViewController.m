//
//  ServicesViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ServicesViewController.h"
#import "YDBlueToothMgr.h"

@interface ServicesViewController ()

@property (nonatomic, strong) YDBlueToothMgr *mgr;  // 单例可能创建的地址是一样，可能状体发生了变化

@end

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    };

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- custom methods

- (ServicesViewController *(^)(YDBlueToothMgr *paramMgr))vcMgr {
    return ^(YDBlueToothMgr *paramMgr) {
        _mgr = paramMgr;
        return self;
    };
}




@end
