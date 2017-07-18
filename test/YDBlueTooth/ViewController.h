//
//  ViewController.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BabyBluetooth;
@class CBPeripheral;

@interface ViewController : UIViewController

//@property (nonatomic, strong) BabyBluetooth *baby;

@property __block NSMutableArray *services;
@property(strong,nonatomic) CBPeripheral *currPeripheral;

@end

