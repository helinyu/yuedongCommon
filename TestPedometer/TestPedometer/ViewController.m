//
//  ViewController.m
//  TestPedometer
//
//  Created by Aka on 2017/8/29.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "YDPedometerMgr.h"

#import "QYPedometerManager.h"
#import "QYPedometerData.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *floorAscendedLabel;
@property (nonatomic, strong) UILabel *floorDescendedLabel;
@property (nonatomic, strong) UILabel *paceLabel;
@property (nonatomic, strong) UILabel *cadenceLabel;

@property (nonatomic, strong) CMPedometer *pedometer;
@property (nonatomic, strong) QYPedometerManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test0];
    [self createComponent];
//    [self test1];
}

- (void)test1 {
//    self.pedometer = [[CMPedometer alloc]init];
    CMPedometer *pedometer = [[CMPedometer alloc] init];
    
    //判断记步功能
    if ([CMPedometer isStepCountingAvailable]) {
        [pedometer queryPedometerDataFromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*2] toDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*1] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error====%@",error);
            }else {
                NSLog(@"步数====%@",pedometerData.numberOfSteps);
                NSLog(@"距离====%@",pedometerData.distance);
            }
        }];
    }else{
        NSLog(@"记步功能不可用");
    }
}

- (void)test0 {
    _stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40, 200)];
    _stepLabel.numberOfLines = 5;
    _stepLabel.backgroundColor = [UIColor redColor];
    _stepLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_stepLabel];
    
    __weak typeof (self) weakSelf = self;
    _mgr = [[QYPedometerManager alloc] init];
    [_mgr startPedometerUpdatesTodayWithHandler:^(QYPedometerData *pedometerData, NSError *error) {
        NSLog(@"pedometer datas ; %@",pedometerData);
         if (!error) {
             weakSelf.stepLabel.text = [NSString stringWithFormat:@" 步数:%@\n 距离:%@\n 爬楼:%@\n 下楼:%@", pedometerData.numberOfSteps, pedometerData.distance, pedometerData.floorsAscended, pedometerData.floorsDescended];
         }
     }];
}

- (void)createComponent {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"开始计算步数" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onStartPedometer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 200, 30);
    
    _stepLabel = [UILabel new];
    [self.view addSubview:_stepLabel];
    _stepLabel.frame = CGRectMake(100, 140, 200, 30);

    _distanceLabel = [UILabel new];
    [self.view addSubview:_distanceLabel];
    _distanceLabel.frame = CGRectMake(100, 170, 200, 30);
    
    _floorAscendedLabel = [UILabel new];
    [self.view addSubview:_floorAscendedLabel];
    _floorAscendedLabel.frame = CGRectMake(100, 200, 200, 30);
    
    _floorDescendedLabel = [UILabel new];
    [self.view addSubview:_floorDescendedLabel];
    _floorDescendedLabel.frame = CGRectMake(100, 230, 200, 30);
    
    _paceLabel = [UILabel new];
    [self.view addSubview:_paceLabel];
    _paceLabel.frame = CGRectMake(100, 260, 200, 30);
    
    _cadenceLabel = [UILabel new];
    [self.view addSubview:_cadenceLabel];
    _cadenceLabel.frame = CGRectMake(100, 290, 100, 30);
}

- (void)onStartPedometer {
    if ([YDPedometerMgr isAvaibleCheckAll]) {
        if ([CMPedometer isPedometerEventTrackingAvailable]) {
            _pedometer = [CMPedometer new];
            NSDate *toDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *fromDate =  [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
            [_pedometer startPedometerUpdatesFromDate:fromDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
                NSLog(@"pedometer data : %@",pedometerData);
                NSLog(@"step:%@ distance : %@, floorA ; %@, floorD: %@,pace :%@,currentCadence:%@",pedometerData.numberOfSteps,pedometerData.distance,pedometerData.floorsAscended,pedometerData.floorsDescended,pedometerData.currentPace,pedometerData.currentCadence);
                dispatch_async(dispatch_get_main_queue(), ^{
                    _stepLabel.text = [NSString stringWithFormat:@"步数：%@",pedometerData.numberOfSteps];
                    _distanceLabel.text = [NSString stringWithFormat:@"距离：%@",pedometerData.distance];
                    _floorAscendedLabel.text = [NSString stringWithFormat:@"增加楼层:%@",pedometerData.floorsAscended];
                    _floorDescendedLabel.text = [NSString stringWithFormat:@"减少楼层：%@",pedometerData.floorsDescended];
                    _paceLabel.text = [NSString stringWithFormat:@"当前的步伐： %@",pedometerData.currentPace];
                    _cadenceLabel.text = [NSString stringWithFormat:@"韵律： %@",pedometerData.currentCadence];
                });
            }];
        }
    }
    
    NSDate *toDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
    if ([CMPedometer isStepCountingAvailable]) {
        CMPedometer *pedometer = [[CMPedometer alloc] init];
        [pedometer startPedometerUpdatesFromDate:fromDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
             NSLog(@"step:%@ distance : %@, floorA ; %@, floorD: %@,pace :%@,currentCadence:%@",pedometerData.numberOfSteps,pedometerData.distance,pedometerData.floorsAscended,pedometerData.floorsDescended,pedometerData.currentPace,pedometerData.currentCadence);
             dispatch_async(dispatch_get_main_queue(), ^{
                 _stepLabel.text = [NSString stringWithFormat:@"步数：%@",pedometerData.numberOfSteps];
                 _distanceLabel.text = [NSString stringWithFormat:@"距离：%@",pedometerData.distance];
                 _floorAscendedLabel.text = [NSString stringWithFormat:@"增加楼层:%@",pedometerData.floorsAscended];
                 _floorDescendedLabel.text = [NSString stringWithFormat:@"减少楼层：%@",pedometerData.floorsDescended];
                 _paceLabel.text = [NSString stringWithFormat:@"当前的步伐： %@",pedometerData.currentPace];
                 _cadenceLabel.text = [NSString stringWithFormat:@"韵律： %@",pedometerData.currentCadence];
             });
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
