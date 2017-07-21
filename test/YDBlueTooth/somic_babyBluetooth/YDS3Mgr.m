//
//  YDS3Mgr.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDS3Mgr.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>

@interface YDS3Mgr ()

@property (nonatomic, assign) NSInteger step;

@end

@implementation YDS3Mgr

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (void)insertDataToYDOpen:(CBCharacteristic *)characteristic{
    NSLog(@"current charactieristic uuid is ： %@",characteristic.UUID);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
        NSData * data = characteristic.value;
        Byte * resultByte = (Byte *)[data bytes];
        
        for(int i=0;i<[data length];i++){
            if (i == 2) {
                
                int heartNUM = resultByte[i];
                NSString *heatString = [NSString stringWithFormat:@"%d",heartNUM];
                NSLog(@"heart reate string : %@",heatString);
                !_heartRateCallBack?:_heartRateCallBack(heatString);
            }
        }
    }else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF3"]]) {
        //步数
        NSData * data = characteristic.value;
        Byte * resultByte = (Byte *)[data bytes];
        
        for(int i=0;i<[data length];i++){
            int a = resultByte[3];
            _step = resultByte[2];
            if (a !=0) {
                _step = resultByte[2] + 256*a;
            }
            if (i == 2) {
                
                //卡路里
                CGFloat calorieValue = (_step * 0.5 / 14);
                NSLog(@"calorieVaule is : %f",calorieValue);
                
                //距离
                CGFloat disMValue = (_step * 0.5 / 1000);
                NSLog(@"disMValue : %f",disMValue);
                !self.tripCallBack?:self.tripCallBack(calorieValue,disMValue);
            }
        }
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]){
    }
}



@end
