//
//  YDReadWriteMgr.m
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/9.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDDatasMgr.h"

@implementation YDDatasMgr

+ (NSData *)convertToDatsWithStepState:(BOOL)state {
    Byte idByte = 0x01;
    if (state == 0) {
        Byte stateByte[] = {idByte,0x00};
        NSData *openDatas = [[NSData alloc] initWithBytes:stateByte length:2];
        return openDatas;
    }else{
        Byte closeByte[] = {idByte,0x01};
        NSData *closeDatas = [[NSData alloc] initWithBytes:closeByte length:2];
        return closeDatas;
    }
}

@end
