//
//  AKAPeirpheralManger.m
//  AKACentral
//
//  Created by Aka on 2017/8/10.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "AKAPeirpheralManger.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface AKAPeirpheralManger ()<CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *peripheralManger;

@property (nonatomic, strong) CBMutableService *controlService;
@property (nonatomic, strong) CBMutableService *stepService;
@property (nonatomic, strong) CBMutableService *heartRateService;

@end

@implementation AKAPeirpheralManger

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *options = @{CBPeripheralManagerOptionShowPowerAlertKey:@(YES),CBPeripheralManagerOptionRestoreIdentifierKey:@(YES)};
         _peripheralManger = [[CBPeripheralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(0, 0) options:options];
    }
    return self;
}

#pragma mark -- CBPeripheralMangerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBManagerStatePoweredOn) {
        
    }else{
        NSLog(@"yout peripheral is not on now");
    }
    CBPeripheralManagerAuthorizationStatus status = [CBPeripheralManager authorizationStatus];
    BOOL isAdverting = [_peripheralManger isAdvertising];
    
    NSDictionary *advertiseDataDic = @{CBAdvertisementDataLocalNameKey:@"peri_name",CBAdvertisementDataServiceUUIDsKey:@[@"0xFFF0",@"0xFFF1",@"0xFFF2"]};
    [_peripheralManger startAdvertising:advertiseDataDic];
    
//    [_peripheralManger stopAdvertising];
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary<NSString *, id> *)dict {
//
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(nullable NSError *)error {
    if (error) {
        NSLog(@"advertisement errorr");
        return;
    }
    
    _controlService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:@"0xFFF1"] primary:NO];
    _stepService = [[CBMutableService alloc] initWithType:[[CBUUID UUIDWithString:@"0xFFF2"]] primary:NO];
    _heartRateService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:@"0xFFF3"] primary:NO];
    [_peripheralManger addService:_controlService];
    [_peripheralManger addService:_stepService];
    [_peripheralManger addService:_heartRateService];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(nullable NSError *)error {
    if (error) {
        NSLog(@"add service failure");
        return;
    }
//    add characteristic
    
    //        可读
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF1"]]) {
        Byte bytes[] = {0x01};
        NSData *data = [NSData dataWithBytes:bytes length:1];
        CBMutableCharacteristic *c = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"0xFFF1"] properties:CBCharacteristicPropertyRead value:data permissions:CBAttributePermissionsReadable];
    }
//    可写
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF2"]]) {
        Byte bytes[] = {0x02};
        NSData *data = [NSData dataWithBytes:bytes length:1];
        CBMutableCharacteristic *c = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"0xFFF2"] properties:CBCharacteristicPropertyWrite value:data permissions:CBAttributePermissionsWriteable]
    }
//    通知
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF3"]]) {
        Byte bytes[] = {0x03};
        NSData *data = [NSData dataWithBytes:bytes length:1];
        CBMutableCharacteristic *c = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"0xFFF3"] properties:CBCharacteristicPropertyWrite value:data permissions:CBAttributePermissionsWriteable]
    }
    
}


//desriptors for the characteristic
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic {
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request {
    NSLog(@"didReceiveReadRequest: %d",request.offset);
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests {
    NSLog(@"didReceiveWriteRequests");
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral {
    
}


//下面这三个的属性暂时不用
- (void)peripheralManager:(CBPeripheralManager *)peripheral didPublishL2CAPChannel:(CBL2CAPPSM)PSM error:(nullable NSError *)error {
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didUnpublishL2CAPChannel:(CBL2CAPPSM)PSM error:(nullable NSError *)error {
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel *)channel error:(nullable NSError *)error {
    
}



@end
