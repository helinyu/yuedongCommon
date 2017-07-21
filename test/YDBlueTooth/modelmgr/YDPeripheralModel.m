//
//  PeripheralModel.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDPeripheralModel.h"

@implementation YDPeripheralServiceCharacteristic

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"characteristicUUIDString" : @"characteristicUUID",
             @"properties" : @"properties",
             };
}

@end


@implementation YDPeripheralModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"services" : [YDPeripheralServiceModel class]
             };
}

@end

@implementation YDPeripheralServiceModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"characteristics" : [YDPeripheralServiceCharacteristic class]
             };
}
@end

@implementation YDPeripheralsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"peripherals" : [YDPeripheralModel class]
             };
}

@end
