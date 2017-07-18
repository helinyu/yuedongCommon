//
//  DisplayserviceViewController.h
//  test
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
//@class YDBlueToothMgr;
@class CBPeripheral;

@interface DisplayserviceViewController : ViewController
{
    @public
    BabyBluetooth *baby;

}

@property __block NSMutableArray *services;
@property(strong,nonatomic)CBPeripheral *currPeripheral;

//@property (nonatomic, strong) YDBlueToothMgr *mgr;

@end
