//
//  PeripheralModel.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"


@protocol YDPeripheralServiceCharacteristic <NSObject>
@end
@interface YDPeripheralServiceCharacteristic : NSObject
@property (nonatomic, copy) NSString *characteristicUUIDString;
@property (nonatomic, copy) NSString *properties;
@end

@protocol YDPeripheralServiceModel <NSObject>
@end
@interface YDPeripheralServiceModel :NSObject
@property (nonatomic, copy) NSString *serviceUUIDString;
@property (nonatomic, strong) NSArray<YDPeripheralServiceCharacteristic *> *characteristics;
@end

@interface YDPeripheralModel : NSObject
@property (nonatomic, copy) NSString *peripheralName;
@property (nonatomic, strong) NSArray<YDPeripheralServiceModel *> *services;
@end

@interface YDPeripheralsModel : NSObject
@property (nonatomic, strong)  NSArray<YDPeripheralModel *> *peripherals;
@end





