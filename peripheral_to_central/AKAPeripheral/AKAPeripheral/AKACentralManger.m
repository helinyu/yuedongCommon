//
//  AKACentralManger.m
//  AKAPeripheral
//
//  Created by Aka on 2017/8/10.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "AKACentralManger.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface AKACentralManger()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *centralManger;

@end

@implementation AKACentralManger

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
