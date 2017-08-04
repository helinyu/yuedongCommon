//
//  S3Manager.m
//  YDOpenHardwareThirdPart
//
//  Created by mac-somic on 2017/4/25.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "S3Manager.h"
#import <YDOpenHardwareSDK/YDOpenHardwareManager.h>
#import <YDOpenHardwareSDK/YDOpenHardwareDataProvider.h>
#import <YDOpenHardwareSDK/YDOpenHardwareIntelligentScale.h>
#import <YDOpenHardwareSDK/YDOpenHardwareHeartRate.h>
#import <YDOpenHardwareSDK/YDOpenHardwareSDK.h>

@interface S3Manager ()
{
    int _lastStepNUm;//上一次同步到悦动圈的步数
    int _step;
    int  _calorie;
    float _disM;
    BOOL _isFirstReload;
}

@property (strong, nonatomic, readwrite) NSMutableArray *nDevices;

@end

@implementation S3Manager

+ (instancetype)shareManager{
    
    static S3Manager *_S3Maneger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _S3Maneger = [[S3Manager alloc]init];
        
    });
    return _S3Maneger;
}

- (instancetype)init{
    self = [super init];
    
  
}

#pragma mark -- 蓝牙的代理方法 --






/**
 直接读取特征的值
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"S3ManagerDidUpdataValueForCharacteristic" object:characteristic];
    if (!error) {
        NSError *error1 = nil;
        id dict = [NSJSONSerialization JSONObjectWithData:characteristic.value options:NSJSONReadingMutableContainers error:&error1];
        NSLog(@"dict is : %@",dict);
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self insertDataToYDOpen:characteristic];
    });
}

- (void)insertDataToYDOpen:(CBCharacteristic *)characteristic{
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
        NSData * data = characteristic.value;
        Byte * resultByte = (Byte *)[data bytes];
        
        for(int i=0;i<[data length];i++){
            if (i == 2) {
                
                int heartNUM = resultByte[i];
                NSString *heatString = [NSString stringWithFormat:@"%d",heartNUM];
                
                if (heartNUM == 0) {
                    return;
                }
                
                
                NSDate * now = [self currentTime:[NSDate date]];
                YDOpenHardwareHeartRate *hr = [[YDOpenHardwareHeartRate alloc] init];
                [hr constructByOhhId: nil DeviceId: _device_identify HeartRate: @([heatString integerValue]) StartTime: now EndTime: now UserId: @([_user_id integerValue]) Extra: @"" ServerId:nil Status:nil];
                //插入心率新记录,插入成功后会自动更新传入数据的主键
                [[YDOpenHardwareManager dataProvider] insertHeartRate: hr completion:^(BOOL success) {
                    
                }];
                
                //建立OpenHardwarePedometer
                YDOpenHardwarePedometer *pedomenter = [[YDOpenHardwarePedometer alloc]init];
                
                NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
                NSString *stepStr = [defaluts objectForKey:@"lastInsertStepsS3"];
                
                _lastStepNUm = stepStr.intValue;
                
                
                if (_step == 0 || _lastStepNUm == _step) {
                    return;
                }
                if ((_lastStepNUm > _step)|| (_isFirstReload == YES)) {
                    _lastStepNUm = 0;
                }
                
                [pedomenter constructByOhpId:nil DeviceId:_device_identify NumberOfStep:[NSNumber numberWithInt:(_step-_lastStepNUm)] Distance:[NSNumber numberWithFloat:_disM] Calorie:[NSNumber numberWithInt:_calorie] StartTime:now EndTime:now UserId:@([_user_id integerValue]) Extra:@"" ServerId:nil Status:nil];
                
                //插入计步数据
                [[YDOpenHardwareManager dataProvider] insertPedometer:pedomenter completion:^(BOOL success) {
                    
                    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
                    [defalut setObject:[NSString stringWithFormat:@"%d",_step] forKey:@"lastInsertStepsS3"];
                    _isFirstReload = NO;
                }];
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
                //                //卡路里
                _calorie = (int) (_step * 0.5 / 14);
                //                //距离
                _disM = (float)(_step * 0.5 / 1000);
                
            }
        }
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]){
        
    }
}

/**
 订阅一个特征的值
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
    }
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else {
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}

/**
 //用于检测中心向外设写数据是否成功
 */
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
    }else{
        
    }
    
    [peripheral readValueForCharacteristic:characteristic];
}

/**
 获取当前时区的当前时间
 */
- (NSDate *)currentTime:(NSDate *)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    date = [date dateByAddingTimeInterval:interval];
    return date;
}


#pragma mark -- 检测通知变化的回调操作 --
- (void)YDNtfOpenHardwareUserChange:(NSNotification *)notification{
    
    //向悦动圈解绑设备
    [[YDOpenHardwareManager sharedManager] unRegisterDevice: self.device_identify plug: self.plugName user: @([self.user_id integerValue]) block:^(YDOpenHardwareOperateState operateState) {
        
    }];
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
    [defaluts removeObjectForKey:@"lastInsertStepsS3"];
}

- (void)AppdidFinishLaunch:(NSNotification *)notification{
    
}
- (void) AppWillResignActive:(NSNotification *)notification{
}
- (void) AppDidEnterBackground:(NSNotification *)notification{
}
- (void) AppWillEnterForeground:(NSNotification *)notification{
}
- (void) AppDidBecomeActive:(NSNotification *)notification{
}
- (void) AppWillTerminate:(NSNotification *)notification{
}


@end
