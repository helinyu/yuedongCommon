//
//  ViewController.m
//  TestBluetooth
//
//  Created by Aka on 2017/8/4.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *cMgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cMgr = [ [CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
