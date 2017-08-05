//
//  YDBlueToothTools.h
//  DoStyle
//
//  Created by zmj on 14-8-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "YDBraceletSynchronizeModel.h"
#import "YDBraceletTimePointModel.h"

@protocol YDBlueToothToolsDelegate <NSObject>
@optional
//连接
-(void)loadDeviceList;
-(void)loadConnectSuccessView;
-(void)loadScanFailedView;
//同步
-(void)blueToothStartSyncWithSum:(NSInteger)sum;
-(void)blueToothSyncingWithSeq:(NSInteger)seq;
-(void)blueToothEndSync;
-(void)connectOffSyncFail;

-(void)blueToothSyncWithEmptyPack;
-(void)refreshFootVCUI;//刷新实时数据
-(void)refreshFootConnectView;
-(void)refreshViewWithDeviceSeq:(NSString *)deviceSeq;
//读取常用闹钟
-(void)loadClockWithNumber:(NSInteger)number
                 andStatus:(NSInteger)Status
                   andHour:(NSInteger)hour
                    andMin:(NSInteger)min;
//刷新“我”UI
-(void)refreshMeVCUI;
-(void)refreshEnergyWithStatus:(int)status andEnergy:(int)energy;
@end
@protocol YDBlueToothToolsFilmwareUpdeteDelegate <NSObject>
-(void)loadFilmwareInfo;
@end

@interface YDBlueToothTools : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
+(YDBlueToothTools *)shareBlueToothTools;

-(void)saveSyncModel;

- (void)scanClick;
- (void)connectClick;
- (void)connectOffClick;
-(void)startRealtimeStep;//开启实时计步
-(void)setTimeNotifyWithPeriod:(NSInteger)period;//短睡
-(void)cancelTimeNotify;//取消短睡
-(void)startDataSync;//获取历史数据
-(void)sendDataSyncResultWithBool:(BOOL)isSuccess;
-(void)setPhysicWithHeight:(int)height
                 andWeight:(int)weight
                    andSex:(Byte)sex
                    andAge:(Byte)age
                   andUnit:(Byte)unit;
-(void)setSystemTimeWithYear:(int)year
                    andMonth:(Byte)month
                      andDay:(Byte)day
                     andHour:(Byte)hour
                      andMin:(Byte)min
                      andSec:(Byte)sec;
-(void)setClockWithClock:(Byte)clock
                andStatu:(Byte)statu
                 andHour:(Byte)hour
                  andMin:(Byte)min;
-(void)readClock;
-(void)switchHourRemindWithIsON:(BOOL)isOn;
-(void)setBarceletNameWithName:(NSString *)name;
-(void)stopRealtimeStep;
-(void)startHeartRateTest;

//寻找
-(void)startSearchBle;

/**
 * 结束查找ble设备
 * @return
 */
-(void)endSearchBle;
/**
 * app向ble设备 设置近距离防丢报警
 * @return
 */
-(void)setShortDistanceLostRemind;
/**
 * app向ble设备 设置远距离防丢报警
 * @return
 */
-(void)setLongDistanceLostRemind;

/**
 * app向ble设备 关闭防丢报警
 * @return
 */
-(void)turnOffLostRemind;

/**
 * 读取设备信息
 */
-(void)readDeviceInfo;

/**
 * 读取固件信息
 */
-(void)readFilmwareInfo;

/**
 * 开启电池电量监控
 */
-(void)startEnergyWatch;

/**
 * 关闭电池电量监控
 */
-(void)endEnergyWatch;


/**
 * 目前只进行统一来电处理 app向ble设备设置来电提醒、短信推送类型、以及消息条数（2Bytes 有符号数） NotifyInfo 2Bytes
 */
-(void)newCallNotify;
/**
 * 来电未接，取消震动
 */
-(void)cancelCallNotify;
/**
 * 来电已接，取消震动
 */
-(void)holdCallNotify;
/**
 *
 * 新的讯息
 */
-(void)newMessageNotify;
/**
 * 重置设备
 */
-(void)resetDevice;

/*
 绑定设备
 */
-(void)bondDevice;
/*
 解绑设备
 */
-(void)bondOffDevice;

@property(nonatomic,weak)id<YDBlueToothToolsDelegate>connectDelegate;
@property(nonatomic,weak)id<YDBlueToothToolsDelegate>syncDelegate;
@property(nonatomic,weak)id<YDBlueToothToolsDelegate>normalClockDelegate;
@property(nonatomic,weak)id<YDBlueToothToolsDelegate>meDelegate;
@property(nonatomic,weak)id<YDBlueToothToolsDelegate>electricityDelegate;

@property(nonatomic,weak)id<YDBlueToothToolsDelegate>delegate;

@property(nonatomic,weak)id<YDBlueToothToolsFilmwareUpdeteDelegate>filmwareDelegate;

@property (nonatomic,copy)NSString *infoText;

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;

@property (strong,nonatomic) NSMutableArray *nDevices;
@property (strong,nonatomic) NSMutableArray *nServices;
@property (strong,nonatomic) NSMutableArray *nCharacteristics;
@property (strong ,nonatomic) CBCharacteristic *writeCharacteristic;
@property (strong ,nonatomic) CBCharacteristic *readCharacteristic;

@property (nonatomic,assign) float batteryValue;


@property (nonatomic,assign) NSInteger todayStepNum;
@property (nonatomic,assign) NSInteger todayCalorie;
@property (nonatomic,assign) NSInteger todayDistance;

@property (strong,nonatomic) NSMutableArray *timePointArray;
@property (strong,nonatomic) YDBraceletSynchronizeModel *syncModel;

@property (nonatomic,assign) BOOL isConnect;
@property (nonatomic,copy) NSString *peripheralUUID;
@property (nonatomic,copy) NSString *romVer;
@property (nonatomic,copy) NSString *hardwareVer;
@property (nonatomic,copy) NSString *manufactrue;
@property (nonatomic,copy) NSString *deviceSeq;
@property (nonatomic,assign) NSInteger filmwareVersionSeq;

@property (nonatomic,copy) NSNumber *stepTarget;


@property (nonatomic,assign)BOOL isAutoConnect;
@property (nonatomic,copy) NSString *lastPeripheralUUID;

@property (nonatomic,assign)BOOL isUpdataConnectOff;
@property (nonatomic,assign)BOOL isScan;
@property (nonatomic,assign)BOOL isGetDeviceSeq;

@end
