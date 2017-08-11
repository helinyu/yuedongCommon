//
//  Father.m
//  test_effective
//
//  Created by Aka on 2017/8/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "Father.h"
#import <CoreBluetooth/CoreBluetooth.h>

@implementation Father

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    // value should be Class or Class name.
//    return @{@"UUID" : [CBUUID class]};
//}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    CBUUID *uuid = dic[@"UUID"];
    if (![uuid isKindOfClass:[CBUUID class]]) return NO;
    _UUID = uuid;
    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    if (!_UUID) return NO;
    dic[@"UUID"] = _UUID;
    return YES;
}


@end
