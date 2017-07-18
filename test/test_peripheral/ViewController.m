//
//  ViewController.m
//  test_peripheral
//
//  Created by Aka on 2017/7/17.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController () <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
    
}


- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    switch (peripheral.state) {
            //在这里判断蓝牙设别的状态  当开启了则可调用  setUp方法(自定义)
        case CBPeripheralManagerStatePoweredOn:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"设备名已经打开，可以使用center进行连接"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            [self setUp];
            break;
        }
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"powered off");
            break;
        default:
            break;
    }
}

//配置bluetooch的
-(void)setUp{
    
    //characteristics字段描述, UUID 应该是自己设置的，这里应该是通过硬件来进行获取的
    CBUUID *CBUUIDCharacteristicUserDescriptionStringUUID = [CBUUID UUIDWithString:CBUUIDCharacteristicUserDescriptionString];
    
    /*
     可以通知的Characteristic
     properties：CBCharacteristicPropertyNotify
     permissions CBAttributePermissionsReadable
     */
//    CBMutableCharacteristic *notiyCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:notiyCharacteristicUUID] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    /*
     可读写的characteristics
     properties：CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead
     permissions CBAttributePermissionsReadable | CBAttributePermissionsWriteable
     */
//    CBMutableCharacteristic *readwriteCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readwriteCharacteristicUUID] properties:CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable | CBAttributePermissionsWriteable];
    //设置description
//    CBMutableDescriptor *readwriteCharacteristicDescription1 = [[CBMutableDescriptor alloc]initWithType: CBUUIDCharacteristicUserDescriptionStringUUID value:@"name"];
//    [readwriteCharacteristic setDescriptors:@[readwriteCharacteristicDescription1]];
    
    
    /*
     只读的Characteristic
     properties：CBCharacteristicPropertyRead
     permissions CBAttributePermissionsReadable
     */
//    CBMutableCharacteristic *readCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readCharacteristicUUID] properties:CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];
    
    
//    service1初始化并加入两个characteristics
//    CBMutableService *service1 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID1] primary:YES];
//    [service1 setCharacteristics:@[notiyCharacteristic,readwriteCharacteristic]];
    
    //service2初始化并加入一个characteristics
//    CBMutableService *service2 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID2] primary:YES];
//    [service2 setCharacteristics:@[readCharacteristic]];
    
    //添加后就会调用代理的- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
//    [peripheralManager addService:service1];
//    [peripheralManager addService:service2];
    
}

//3. 开启广播advertising

//perihpheral添加了service
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
//    if (error == nil) {
//        serviceNum++;
//    }
//    
//    //因为我们添加了2个服务，所以想两次都添加完成后才去发送广播
//    if (serviceNum==2) {
//        //添加服务后可以在此向外界发出通告 调用完这个方法后会调用代理的
//        //(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
//        [peripheralManager startAdvertising:@{
//                                              CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:ServiceUUID1],[CBUUID UUIDWithString:ServiceUUID2]],
//                                              CBAdvertisementDataLocalNameKey : LocalNameKey
//                                              }
//         ];
//        
//    }
}

//peripheral开始发送advertising
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    NSLog(@"in peripheralManagerDidStartAdvertisiong");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
