//
//  YDReadWriteMgr.h
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/9.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDDatasMgr : NSObject

+ (instancetype)shared;

+ (NSData *)convertToDatsWithStepState:(BOOL)state;
- (NSData *)ConvertwriteByteToDataWithHeader:(Byte)header andData:(NSData *)data;

@end
