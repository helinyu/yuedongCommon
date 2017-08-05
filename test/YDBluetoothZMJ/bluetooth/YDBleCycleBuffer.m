//
//  YDBleCycleBuffer.m
//  DoStyle
//
//  Created by caojikui on 14-9-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "YDBleCycleBuffer.h"

static YDBleCycleBuffer* instance = nil;
Byte _buffer[1024 * 100];

@implementation YDBleCycleBuffer

+(id)allocWithZone:(NSZone*) zone
{
    if(!instance){
        @synchronized(self){
            if(!instance){
                instance = [super allocWithZone:zone];
            }
        }
    }
    return instance;
}

+(id)sharedInstance
{
    if(!instance){
        instance = [[self alloc]init];
    }
    return instance;
}

-(id)init
{
    self = [super init];
    if(self){
        _capacity = [NSNumber numberWithInt:1024 * 100];
        _startPos = [NSNumber numberWithInt:0];
        _endPos = [NSNumber numberWithInt:0];
    }
    return self;
}

-(BOOL)put:(NSData *)data{
    Boolean rt = false;
    Byte *tempData = (Byte*)[data bytes];
    if ([_startPos integerValue] <= [_endPos integerValue]) {// 非循环状态
        if (data.length <= ([_capacity integerValue]- ([_endPos integerValue] - [_startPos integerValue]))) {// 剩余有足够容量
            NSInteger medlength = [_capacity integerValue] - [_endPos integerValue];
            if (data.length <= medlength) {// 不需要循环
                for (int index = 0; index < data.length; ++index) {
                    _buffer[_endPos.intValue + index] = tempData[index];
                }
                
                _endPos = [NSNumber numberWithInteger:_endPos.intValue + data.length];
            } else {
                for (int index = 0; index < medlength; ++index) {
                    _buffer[_endPos.intValue + index] = tempData[index];
                }
                for (int index = 0; index < data.length - medlength; ++index) {
                    _buffer[index] = tempData[medlength + index];
                }
                _endPos = [NSNumber numberWithInteger:data.length - medlength];
            }
            rt = true;
        }
    } else {// 循环状态
        if (data.length <= (_startPos.intValue - _endPos.intValue)) {// 剩余有足够容量
            for (int index = 0; index < data.length; ++index) {
                _buffer[_endPos.intValue + index] = tempData[index];
            }
            
            _endPos = [NSNumber numberWithInteger:_endPos.intValue + data.length];
            rt = true;
        }
    }
    
    return rt;
}

-(NSData *) getUnit {
    NSData *rt = nil;
    if (_endPos.intValue > _startPos.intValue) {// 非循环
        for (int i = _startPos.intValue; i < _endPos.intValue; i++) {
            if ((int) (_buffer[i] & 0xFF) >= 0x80) {
                Byte length = (Byte) (_buffer[i + 1] & 0xFF);
                Byte unitlength = (Byte) (length + 2);
                if (_endPos.intValue - _startPos.intValue >= unitlength) {// 存在完整数据包
                    Byte byteRt[unitlength];
                    for (int index = i; index < i + unitlength; ++index) {
                        byteRt[index - i] = _buffer[index];
                    }
                    rt = [NSData dataWithBytes:byteRt length:unitlength];
                    _startPos = [NSNumber numberWithInt:i + unitlength];
                }
                break;
                
            }
        }
    } else if (_startPos.intValue > _endPos.intValue) {// 循环
        for (int i = _startPos.intValue; i < _endPos.intValue + _capacity.intValue; i++) {
            if ((int) (_buffer[i % _capacity.intValue] & 0xFF) >= (int) 0x80) {
                Byte length = (Byte) (_buffer[(i + 1) % _capacity.intValue] & 0xFF);
                int unitlength = length + 2;
                if (_capacity.intValue + _endPos.intValue - _startPos.intValue >= unitlength) {// 存在完整数据包
                    Byte byteRt[unitlength];
                    int medLength = _capacity.intValue - _startPos.intValue;
                    if (medLength < unitlength) {
                        for (int index = 0; index < medLength; ++index) {
                            byteRt[index] = _buffer[i % _capacity.intValue + index];
                        }
                        for (int index = 0; index < unitlength - medLength; ++index) {
                            byteRt[medLength + index] = _buffer[index];
                        }
                        
                        rt = [NSData dataWithBytes:byteRt length:unitlength];
                       
                        _startPos = [NSNumber numberWithInt:unitlength - medLength];
                    } else {
                        for (int index = 0; index < unitlength; ++index) {
                            byteRt[index] = _buffer[ i % _capacity.intValue + index];
                        }
                        
                        rt = [NSData dataWithBytes:byteRt length:unitlength];
                        
                        _startPos = [NSNumber numberWithInt:i % _capacity.intValue + unitlength];
                    }
                    
                }
                break;
                
            }
        }
    }
    
    return rt;
    
}

@end
