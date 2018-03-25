//
//  CabDriver.m
//  TestCoreText
//
//  Created by Aka on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CabDriver.h"

@implementation CabDriver

- (void)driverToLocation:(CGPoint )x {
    TaxiMeter *meter = [TaxiMeter new];
    [meter start];
    
    Car *car = [Car new];
    [car releaseBrakes];
    [car changeGeers];
    [car pressAccelerator];
    
//     运行中
    
//    到达目的地的时候
    [car releaseAccelerator];
    [car pressBrakes];
    [meter stop];
    
}

@end
