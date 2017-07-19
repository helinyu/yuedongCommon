//
//  BluetoothS3ViewController.m
//  SOMICS3
//
//  Created by mac-somic on 2017/4/16.
//  Copyright © 2017年 mac-somic. All rights reserved.


#import "BluetoothS3ViewController.h"

#import <YDOpenHardwareSDK/YDOpenHardwareManager.h>
#import <YDOpenHardwareSDK/YDOpenHardwareDataProvider.h>
#import <YDOpenHardwareSDK/YDOpenHardwareIntelligentScale.h>
#import <YDOpenHardwareSDK/YDOpenHardwareHeartRate.h>
#import <YDOpenHardwareSDK/YDOpenHardwareSDK.h>
#import <YDOpenHardwareSDK/YDOpenHardwarePedometer.h>
#import "SVProgressHUD.h"
#import "BluetoothConnectViewController.h"
#import "S3MainView.h"
#import "S3MianViewModel.h"
#import "S3Manager.h"



@interface BluetoothS3ViewController ()<S3MainViewDelegate,BluetoothDaterViewDelegate>
{
    NSString *dateTime;
    int  _calorie;
    float _disM;
    int _step;
}

@property (strong, nonatomic ) S3MainView *mainView;

@end

@implementation BluetoothS3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColorFromRGB(0x333333);
    self.title = @"S3耳机";
    
    [self initVeiw];
    
    [self GetYDData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidUpdataValueForCharacteristic:) name:@"S3ManagerDidUpdataValueForCharacteristic" object:nil];
    
    [S3Manager shareManager];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)GetYDData{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateTime = [formatter stringFromDate:[NSDate date]];
}

- (void)initVeiw{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(S3Back)];
    [self.view addSubview:self.mainView];
}

#pragma mark -- button click
- (void)blueBtnSearchClick{// 搜索设备
    [[S3Manager shareManager] scanForPeripherals];
    
    BluetoothConnectViewController *BluetoothTableV = [[BluetoothConnectViewController alloc]initBlueVCWithArray:[S3Manager shareManager].nDevices];
    [self.navigationController pushViewController:BluetoothTableV animated:YES];
}
- (void)dayRightSearch{
    self.mainView.dater=[[BluetoothDaterView alloc]initWithFrame:CGRectZero];
    self.mainView.dater.delegate=self;
    [self.mainView.dater showInView:self.view animated:YES];
}

- (void)blueStartRun{// 连接
    if ([[S3Manager shareManager].peripheral.name isEqualToString:@"S3"]) {
        [[S3Manager shareManager] connectS3Bluetooth];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"请选择蓝牙设备"];
        return;
    }
}
- (void)S3Back {
    if (self.navigationController) {
        if (self.navigationController.childViewControllers.count <= 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
#pragma mark -- BluetoothDaterViewDelegate
- (void)daterViewDidClicked:(BluetoothDaterView *)daterView{
    if (![S3Manager shareManager].device_identify){
        [SVProgressHUD showErrorWithStatus:@"还没有绑定设备"];
        return;
    }
    self.mainView.dayMidLab.text = daterView.dateString;
    if (![daterView.dateString isEqualToString:dateTime]) {
        self.mainView.todayMidLab.text = @"历史记录";
    }else{
        self.mainView.todayMidLab.text = @"今天";
    }
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSString *dateString = [NSString stringWithFormat:@"%@ 00:00:00",daterView.dateString];
    NSDate * date = [self currentTime:[dateFormat dateFromString:dateString]];
    NSDate *date1 =[NSDate dateWithTimeInterval:(24*60*60-2) sinceDate:date];

    //心率 根据条件获取多条记录
    [[YDOpenHardwareManager dataProvider] selectHeartRateByDeviceIdentity:[S3Manager shareManager].device_identify timeSec:nil userId:@([[S3Manager shareManager].user_id integerValue]) betweenStart:date end:date1 completion:^(BOOL success, NSArray<YDOpenHardwareHeartRate *> *data) {
        if (success) {
            if (data.count>0) {
                NSMutableArray *array = [[NSMutableArray alloc]init];
                NSInteger count = data.count;
                for (int i = 0; i < count; i ++) {
                    NSNumber *number = data[i].heartRate;
                    if (number.intValue > 0) {
                         [array addObject:number];
                    }
                }
                NSInteger count1 = array.count;
                long totalheartRate = 0;
                for (int j = 0; j < count1; j ++) {
                    long heartRateCount = [array[j] longValue];
                    totalheartRate = totalheartRate + heartRateCount;
                }
                long heartRateAvg = totalheartRate/count1;
                self.mainView.heatRateLab.text = [NSString stringWithFormat:@"%ld",heartRateAvg];
            }else{
                [self YDQBackHasNOData];
            }
        }
    }];

    //计步 根据条件获取多条记录
    [[YDOpenHardwareManager dataProvider] selectPedometerByDeviceIdentity:[S3Manager shareManager].device_identify timeSec:nil userId:@([[S3Manager shareManager].user_id integerValue]) betweenStart:date end:date1 completion:^(BOOL success, NSArray<YDOpenHardwarePedometer *> *data) {
        if (success) {
            if (data.count > 0) {
                NSMutableArray *array = [[NSMutableArray alloc]init];
                NSInteger count = data.count;
                for (int i = 0; i < count; i ++) {
                    NSNumber *number = data[i].numberOfStep;
                    [array addObject:number];
                }
                NSInteger count1 = array.count;
                long totalStep = 0;
                for (int j = 0; j < count1; j ++) {
                    long stepCount = [array[j] longValue];
                    totalStep = totalStep + stepCount;
                }
                //卡路里
                NSString * calorieNUM = [NSString stringWithFormat:@"%ld",(long) (totalStep * 0.5 / 14)];
                //距离
                 NSString * distanceNUM = [NSString stringWithFormat:@"%.2f",(float)(totalStep * 0.5 / 1000)];
                self.mainView.stepNumLab.text = [NSString stringWithFormat:@"%ld",totalStep];
                //卡路里
                self.mainView.hotLab.text = [S3MianViewModel stringToNULL:calorieNUM];
                //距离
                self.mainView.distanceLab.text = [S3MianViewModel stringToNULL:distanceNUM];
            }else{
                [self YDQBackHasNOData];
            }
        }
    }];
}

/**
 悦动圈数据库返回数据为空
 */
- (void)YDQBackHasNOData{
    self.mainView.heatRateLab.text = @"0";
    self.mainView.stepNumLab.text = @"0";
    self.mainView.hotLab.text = @"0";
    self.mainView.distanceLab.text = @"0";
}

- (void)daterViewDidCancel:(BluetoothDaterView *)daterView
{
    
}
#pragma mark -- 蓝牙的代理方法 --

-(void)DidUpdataValueForCharacteristic:(NSNotification *)notification{
    CBCharacteristic *characteristic = notification.object;
    
    //心率
    if (![self.mainView.todayMidLab.text isEqualToString:@"今天"]) {
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
        NSData * data = characteristic.value;
        Byte * resultByte = (Byte *)[data bytes];
        
        for(int i=0;i<[data length];i++){
            if (i == 2) {
                
                if (resultByte[1] == 9) {
                    [SVProgressHUD showErrorWithStatus:@"请开启运动模式！"];
                    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"运动模式未开启" message:@"(请在蓝牙耳机开启运动模式按钮)" preferredStyle:UIAlertControllerStyleActionSheet];
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }else if(resultByte[1] == 8) {
                    [SVProgressHUD showSuccessWithStatus:@"运动模式已开启！"];
                }
                
                
                int heartNUM = resultByte[i];
                NSString *heatString = [NSString stringWithFormat:@"%d",heartNUM];
                
                if (heartNUM == 0) {
                    return;
                }
                
                self.mainView.heatRateLab.text = heatString;
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
                self.mainView.stepNumLab.text = [NSString stringWithFormat:@"%d",_step];
                
                //卡路里
                _calorie = (int) (_step * 0.5 / 14);
                self.mainView.hotLab.text = [NSString stringWithFormat:@"%d",_calorie];
                //距离
                _disM = (float)(_step * 0.5 / 1000);
                self.mainView.distanceLab.text = [NSString stringWithFormat:@"%.2f",_disM];
                
            }
        }
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]){
        
    }

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

#pragma mark -- 懒加载 --
- (S3MainView *)mainView{
    if (!_mainView) {
        _mainView = [[S3MainView alloc]init];
        _mainView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _mainView.delegate = self;
    }
    return _mainView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
