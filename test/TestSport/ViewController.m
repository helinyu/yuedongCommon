//
//  ViewController.m
//  TestSport
//
//  Created by Aka on 2017/8/5.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "YDBlueToothTools.h"

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CBCentralManager *centralManage;

@property (nonatomic, strong) CBPeripheral *peripheral;

@end

static NSString *const reuseIdentify = @"reuseIdentify";

#define kSeverviceUUID @"3D9E5046-325A-A248-F1FE-15380D827D21"//获取到的设备的UUID，测试绑定的时候用的

#define kStepServiceUUID @"0C301900-BEB8-5C69-8714-099C77103418"//服务的UUID

#define kStepRecordsUUID @"0C302ABC-BEB8-5C69-8714-099C77103418"//特征的UUID


#define kStepControl @"0C302ABE-BEB8-5C69-8714-099C77103418"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   uint a =  GAPBOND_PAIRING_MODE_WAIT_FOR_REQ;

    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    scanBtn.frame = CGRectMake(60, 60, 100, 30);
    [self.view addSubview:scanBtn];

    UIButton *connectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [connectBtn setTitle:@"连接" forState:UIControlStateNormal];
    [connectBtn addTarget:self action:@selector(toConnect) forControlEvents:UIControlEventTouchUpInside];
    connectBtn.frame = CGRectMake(200, 60, 100, 30);
    [self.view addSubview:connectBtn];
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-100) style:UITableViewStylePlain];
//    [self.view addSubview:_tableView];
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentify];
//    _tableView.backgroundColor = [UIColor yellowColor];
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDatas) name:@"yd.reload" object:nil];

}

#pragma mark -扫描蓝牙外设

- (void)scanBtnClick

{
    
    //创建中心设备管理器并设置当前控制器试图为代理
    
    _centralManage= [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
}

#pragma mark - CBCentralManagerDelegate代理方法

//中心服务器状态更新后

- (void)centralManagerDidUpdateState:(CBCentralManager*)central

{
    
    switch(central.state)
    
    {
            
            //蓝牙为开启状态，iOS应该是8以后吧，不加状态判断崩溃
            
        case CBCentralManagerStatePoweredOn:
            
            NSLog(@"BLE已打开");
            
        {
            self.centralManage= central;
            
            //这里填写nil，会扫描所有外设，但是当我写入一个指定的外设UUID的时候，却扫不到任何设备，目前不清楚是什么原因，希望大家告知。
            [central scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
            
        }
            
            break;
            
        default:
            
            NSLog(@"此设备不支持BLE或未打开蓝牙功能,无法作为外围设备");
            
            break;
            
    }
    
}

#pragma mark - 发现外设

- (void)centralManager:(CBCentralManager*)central didDiscoverPeripheral:(CBPeripheral*)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber*)RSSI

{
    
    //根据外设名的前缀来查找相应的外设，本来在绑定的时候我打算通过判断外设的名字来绑定设备的，但是发现行不通，当时就这个绑定问题很是苦恼
    if([peripheral.name hasPrefix:@"SH"])
        
    {
        
        
        //坑来啦!就是这个坑啊，在这里可以获取到外设的 identifier，name 和 RSSI（信号强弱），我一直以为identifier就是外设的UUID，就一直用peripheral.identifier来做判断，一直就不走方法，打印出来的identifier你会发现是这样一串字符"<__NSConcreteUUID 0x15106e470> 3D9E5046-325A-A248-F1FE-15380D827D21"，UUID前面还有一串字符，所以说identifier并不是真正的UUID。最后发现identifier还有个UUIDString的方法，接下来就可以通过判断UUIDString和当前设备的UUID是否一致来选择是否连接该设备来实现绑定。
        [[NSUserDefaults standardUserDefaults] setObject:peripheral.identifier.UUIDString forKey:@"peripheralUUID"];
        
        //停止扫描
        
        [self.centralManage stopScan];
        
        NSLog(@"获得的外设的UUID---%@",peripheral.identifier.UUIDString);
        
        NSLog(@"advertisementData--%@",advertisementData);
        
        NSLog(@"*****没有绑定*****");
        
        self.peripheral= peripheral;
        
        NSLog(@"开始连接外围设备");
        
        //[self.centralManage connectPeripheral:peripheral options:nil];
        
        [self.centralManage connectPeripheral:peripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
        
        GAPBOND_PAIRING_MODE_INITIATE
        
    }
    
}

#pragma mark -连接到外围设备

- (void)centralManager:(CBCentralManager*)central didConnectPeripheral:(CBPeripheral*)peripheral

{
    
    NSLog(@"连接外围设备成功");
    
    
    //连接成功后建立一个通知,通知相机连接已完成（这个是写的自定义相机来实现蓝牙控制拍照）
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"connected" object:nil];
    
    //设置外围设备的代理为当前控制器
    
    peripheral.delegate=self;
    
    //外围设备开始寻找服务
    
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kStepServiceUUID]]];
    
}

#pragma mark - CBPeripheralDelegate代理方法

//外围设备寻找到服务器后

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(nullable NSError*)error

{
    
    NSLog(@"已发现可用服务...");
    
    if(error)
    {
        NSLog(@"外围设备寻找服务过程中发生错误,");
    }
    
    //遍历查找到的服务
    
    CBUUID*serviceUUID = [CBUUID UUIDWithString:kStepServiceUUID];
    
    CBUUID*stepRecordsUUID = [CBUUID UUIDWithString:kStepRecordsUUID];
    
    CBUUID*stepControl = [CBUUID UUIDWithString:kStepControl];
    
    for(CBService*service in peripheral.services)
        
    {
        
        if([service.UUID isEqual:serviceUUID])
            
        {
            
            //外围设备查找指定服务中的特征
            
            [peripheral discoverCharacteristics:@[stepRecordsUUID,stepControl] forService:service];
            
        }
        
    }
    
}

#pragma mark - 外围设备寻找到特征后

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(nullable NSError*)error

{
    
         //在这里向外设写入内容，先遍历特征，遍历到可写入的特征
    
        //写入特征也比较坑，当时我拿到的硬件文档纯英文的不说，而且给的东西很少，很不清晰，你所写入的数据应该是硬件那边提供的，写入的分方法就是writeValue
    
    //写入目标
    
//    [peripheral writeValue:[NSDatadataWithBytes:(uint8_t[]){43, goal, goal>>8,0,2} length:5] forCharacteristic:characterstic type:CBCharacteristicWriteWithResponse];//这是我写入目标的一种数据格式
    
}

#pragma mark - 特征值被更新后

- (void)peripheral:(CBPeripheral*)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic*)characteristic error:(nullable NSError*)error

{
    
    NSLog(@"收到特征更新通知...");
    
    if(error)
        
    {
        
        NSLog(@"更新通知状态时发生错误,错误信息:");
    }
    
    //给特征值设置新的值
    
    CBUUID *stepRecordsUUID = [CBUUID UUIDWithString:kStepRecordsUUID];
    
    if([characteristic.UUID isEqual:stepRecordsUUID])
        
    {
        
        if(characteristic.isNotifying)
            
        {
            if(characteristic.properties == CBCharacteristicPropertyNotify)
                
            {
                NSLog(@"已订阅特征通知");
                [peripheral readValueForCharacteristic:characteristic];
                return;
            }
            else if(characteristic.properties == CBCharacteristicPropertyRead)
            {
                
                //从外围设备读取新值,调用此方法会触发代理方法:- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
                
                [peripheral readValueForCharacteristic:characteristic];
                
            }
            else
            {
                NSLog(@"停止已停止");
                //取消连接
                [self.centralManage cancelPeripheralConnection:peripheral];
                
            }
            
        }
        
    }
    
}

#pragma mark - 更新特征后(调用readValueForCharactrtistic:方法或者外围设备在订阅后更新特征值都会调用此方法)

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForCharacteristic:(CBCharacteristic*)characteristic error:(nullable NSError*)error

{
    
    //在这里读取外设传来的数据
    
    //这只是一部分代码
    
    NSData*data = characteristic.value;
    
    uint32_t minuteTimestamp =0;
    
    [data getBytes:&minuteTimestamp range:NSMakeRange(1,3)];
    
    const uint8_t*bytes = data.bytes;
    
    if(minuteTimestamp !=0)
        
    {
        
        NSDate*time = [NSDate date];
        
        NSTimeZone*zone = [NSTimeZone systemTimeZone];
        
        NSInteger interval = [zone secondsFromGMTForDate:time];
        
        NSDate*localDate = [time dateByAddingTimeInterval:interval];
        
//        
//         localDate, bytes[4], bytes[5], bytes[6], bytes[7], bytes[8]];
//        
//        NSString*dateString = [NSString stringWithFormat:@"%@",localDate];
//        
//        NSLog(@"======dateString====%@",dateString);
//        
//        NSString*stepCount = [NSString stringWithFormat:@"%u",bytes[4]+bytes[5]+bytes[6]+bytes[7]+bytes[8]];
//        
//        //把数据存入数据库中
//        
//        [StepDAO insertData:dateString AndSteps:stepCount];
//        
//        NSLog(@"读取到的特征时间和步数:%@,%@",newText,stepCount);
        
        //其他的卡路里什么的计算就不写了，太复杂..算法是客户那边提供的..看着都恶心..
        
    }
}
@end
