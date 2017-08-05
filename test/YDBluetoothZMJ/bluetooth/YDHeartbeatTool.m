//
//  YDHeartbeatTool.m
//  SportsBar
//
//  Created by 卓名杰 on 10/11/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "YDHeartbeatTool.h"
#import "Reachability.h"
#import "TimeConversion.h"
#import "YDTools.h"
#import "YDDB.h"
//#import "YDFitnessDayDetailModel.h"
//#import "YDFitnessMgr.h"
//#import "YDFitnessDB.h"
//#import "YDUserInstance.h"
//#import "YDDataSolver.h"
//#import "MSBaseResult.h"
//#import "MSAFHttpKit.h"

@implementation YDHeartbeatTool
{
    NSTimer *_heartbeatTimer;
    NSInteger _heartbeatNum;
    NSNumber *_uploadDataBaseTimeNum;
//    YDRunModel *_runnerModel;
//    YDRunModel *_autoDayModel;
//    YDBraceletDayModel *_braceletDayModel;
    BOOL _isNetWork;
    NSNumber *_sportInfoDownloadStatusInitTimeInterval;
    NSString *_reportFitnessUUID;
//    YDFitnessDayDetailModel *_fitnessModel;
}

static YDHeartbeatTool *singleton;


+(YDHeartbeatTool *)shareHeartbeatTool
{
    if (singleton == nil) {
        singleton = [[YDHeartbeatTool alloc] init];
    }
    return singleton;
}
-(id)init
{
    self = [super init];
    if (self) {
        [self initData];
        [self msBindHttpNotifycation];
    }
    return self;
}

-(void)initData
{
//    _userModel = [UserModel shareUserModel];
    _heartbeatNum = 0;
//    NSDictionary *umOnlineDic = [[NSUserDefaults standardUserDefaults] objectForKey:UM_ONLINE_DIC];
//    _uploadDataBaseTimeNum = [NSNumber numberWithInteger:((NSNumber *)[umOnlineDic objectForKey:UM_UPLOAD_DATABASE_TIME_INTERVAL]).integerValue];
//    if ([umOnlineDic objectForKey:UM_UPLOAD_DATABASE_TIME_INTERVAL] == nil) {
//        _uploadDataBaseTimeNum = @10;
//    }
//    _sportInfoDownloadStatusInitTimeInterval = [umOnlineDic objectForKey:@"sport_info_download_status_init_time_interval"];
    if (_sportInfoDownloadStatusInitTimeInterval == nil) {
        _sportInfoDownloadStatusInitTimeInterval = @60;
    }
    _heartbeatTimer=[[NSTimer alloc]initWithFireDate:[NSDate date] interval:60 target:self selector:@selector(heartbeatActivity) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_heartbeatTimer forMode:NSRunLoopCommonModes];
}

- (void)heartbeatActivity {
    [self heartbeatActivityWithCompletion:nil];
}

-(void)heartbeatActivityWithCompletion:(void (^)(void))completion
{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        if ( _heartbeatNum%_uploadDataBaseTimeNum.integerValue == 0 && ![YDSportTool shareSportTool].isSportRecording) {
//            [self uploadRunnerDataWithCompletion:^{
//                [self updateBraceletTodayModelWithCompletion:^{
//                    [self uploadBraceletDayDataWithCompletion:^{
//                        if (_heartbeatNum%_sportInfoDownloadStatusInitTimeInterval.integerValue == 0) {
////                            [[YDSportTool shareSportTool] initSportInfoDownloadStatus];
//                        }
//                        _heartbeatNum++;
//                        if (completion) {
//                            completion();
//                        }
//                    }];
//                }];
//            }];
//
//        } else {
//            if (_heartbeatNum%_sportInfoDownloadStatusInitTimeInterval.integerValue == 0) {
////                [[YDSportTool shareSportTool] initSportInfoDownloadStatus];
//            }
//            _heartbeatNum++;
//            if (completion) {
//                completion();
//            }
//        }
//    });
    
}

- (void)updateBraceletTodayModelWithCompletion:(void (^)(void))completion {
//    if (![YDSportTool shareSportTool].isSportRecording) {
//        YDSportTool *sportTool = [YDSportTool shareSportTool];
//        if (sportTool.braceletDeviceSeq != nil && sportTool.bandType != BandTypeV) {
//            NSNumber *todayNum = [TimeConversion numberFromDate:[NSDate date]];
//            __block YDBraceletDayModel *dayModel;
//            [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                dayModel = [YDDBTable db:db selectBraceletDayRecordFromDataBaseForUserId:[YDAppInstance userId] DayNum:todayNum andDeviceSeq:sportTool.braceletDeviceSeq];
//            } completHandler:^{
//                if (dayModel != nil) {
//                    if (sportTool.braceletStepDate != nil) {
//                        NSNumber *braceletDay = [TimeConversion numberFromDate:sportTool.braceletStepDate];
//                        if (braceletDay.integerValue == todayNum.integerValue) {
//                            dayModel.steps = [NSNumber numberWithInteger:sportTool.braceletStep];
//                            dayModel.distance = [NSNumber numberWithFloat:[YDTools distanceWithStep:dayModel.steps.integerValue]];
//                            dayModel.caloric = [NSNumber numberWithFloat:[YDTools calorieWithDistance:dayModel.distance.floatValue]];
//                            dayModel.isUp = NO;
//                            [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                                [YDDBTable db:db updateBraceletDayRecordWithModel:dayModel andSyncId:dayModel.syncID];
//                            } completHandler:^{
//                                if (completion) {
//                                    completion();
//                                }
//                            }];
//                        }
//                    }
//                }
//            }];
//        }
//    }
}

-(void)uploadRunnerDataWithCompletion:(void (^)(void))completion
{
//    if (![YDSportTool shareSportTool].isSportRecording) {
//        __block YDRunModel *model;
//        [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//            model = [YDDBTable db:db selectFirstDistanceRecordNoUploadFromAccountForUserID: _userModel.userID];
//        } completHandler:^() {
//            if (model) {
//                _runnerModel = model;
//                [self uploadRunnerModelWithCompletion:completion];
//            }
//        }];
//    } else {
//        if (completion) {
//            completion();
//        }
//    }
}

-(void)uploadBraceletDayDataWithCompletion:(void (^)(void))compeltion
{
//    if (![YDSportTool shareSportTool].isSportRecording) {
//        NSNumber *currentDayNum = [TimeConversion getDayNumWithSecond:[NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970]];
//        __block YDBraceletDayModel *model;
//        [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//            model = [YDDBTable db:db selectFirstBraceletDayRecordNoUploadFromDataBaseForUserID: _userModel.userID];
//        } completHandler:^{
//            if (model) {
//                if (model.dayNum.integerValue < currentDayNum.integerValue || ![model.peripheralUUID isEqualToString:@"nodevice"]) {
//                    _braceletDayModel = model;
//                    _autoDayModel = nil;
//                    _isBraceletDayUpload = YES;
//                    [self uploadBraceletDayModel];
//                }
//            }
//            if (compeltion) {
//                compeltion();
//            }
//        }];
//    }
}

- (void)uploadRunnerModelWithCompletion:(void (^)(void))completion {
//    NSLog(@"上报跑步数据");
    _isNetWork = YES;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            _isNetWork = NO;
            
            break;
        case ReachableViaWWAN:
            // 使用3G网络
//            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
//            NSLog(@"正在使用wifi网络");
            break;
    }
    if (_isNetWork) {
//        if (_runnerModel.kindID.integerValue == 0 && _runnerModel.kindID.integerValue == 3) {
//            __block NSArray<YDRunPoint *> *rpa;
//            [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                rpa = [YDRunPointTable selectYDRunPointByRecordId: _runnerModel.localRunnerID fromDb: db];
//            } completHandler:^{
//                if (rpa && rpa.count > 0) {
//                    NSMutableArray *ja = [NSMutableArray array];
//                    for (YDRunPoint *rp in rpa) {
//                        [ja addObject: [rp jsonDic]];
//                    }
//                    _runnerModel.detail = [MSJsonKit objToJson: ja withKey: nil];
//                }
//                [[YDUserInstance sportMgr] reportRunnerInfoOfMid: 4 param: [YDDataSolver reportRunnerInfoWithRunnerModel: _runnerModel]];
//                if (completion) {
//                    completion();
//                }
//            }];
//        } else {
//            [[YDUserInstance sportMgr] reportRunnerInfoOfMid: 4 param: [YDDataSolver reportRunnerInfoWithRunnerModel: _runnerModel]];
//            if (completion) {
//                completion();
//            }
//        }
    } else {
        if (completion) {
            completion();
        }
    }
}

- (void)uploadBraceletDayModel {
//    NSLog(@"上报跑步数据");
    _isNetWork = YES;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            _isNetWork = NO;
            
            break;
        case ReachableViaWWAN:
            // 使用3G网络
//            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
//            MSLogI(@"正在使用wifi网络");
            break;
    }
    if (_isNetWork) {
//        if (_braceletDayModel != nil) {
//            if ([_braceletDayModel.peripheralUUID isEqualToString:@"nodevice"] || _braceletDayModel.deviceSeq != nil) {
//            }
//        }
//        else if(_autoDayModel != nil)
//        {
//            [[YDUserInstance sportMgr] reportRunnerInfoOfMid: 5 param: [YDDataSolver reportRunnerInfoWithRunnerModel: _autoDayModel]];
//        }
    }
}

-(NSNumber *)getNextDayNumWithDayNum:(NSNumber *)dayNum
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate* inputDate = [inputFormatter dateFromString:dayNum.stringValue];
    NSTimeInterval showDay=inputDate.timeIntervalSince1970+24*60*60;
    NSNumber *nextDayNum = [TimeConversion getDayNumWithSecond:[NSNumber numberWithDouble:showDay]];
    return nextDayNum;
}

- (void)reportRunnerPathData{
//    [[YDUserInstance sportMgr] reportRunnerPathDataOfMid: 1 param: [YDDataSolver reportRunnerPathDataWithRunnerModel: _runnerModel]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma http
- (void)msBindHttpNotifycation {
//    [super msBindHttpNotifycation];
//    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(msReportRunnerInfoFinished:) name: NTF_HTTP_REPORT_RUNNER_INFO object: nil];
//    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(msReportRunnerPathDataFinished:) name: NTF_HTTP_REPORT_RUNNER_PATH_DATA object: nil];
//    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(msReportRunnerInfoBraceletFinished:) name: NTF_HTTP_REPORT_RUNNER_INFO_BRACELET object: nil];
}

- (void)msReportRunnerInfoFinished: (NSNotification *)notification {
//    MSBaseResult *br = notification.object;
//    if (br.mid == 4) {
//        if (br.success) {
//            NSDictionary *dic = br.data;
//            _runnerModel.runnerID=dic[@"runner_id"];
//
//            if (_runnerModel.kindID.integerValue == 1) {
//                [self reportRunnerPathData];//室内跑分开上报detai.
//            } else {
//                _runnerModel.isUp=YES;
//                _runnerModel.isGetRunner=YES;
//                __block YDRunModel *model;
//                [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                    [YDDBTable db:db updateRunnerFromDataBase:_runnerModel andLocalRunnerID:_runnerModel.localRunnerID];
//                    model = [YDDBTable db:db selectRunnerFromDataBaseForLocalRunnerID:_runnerModel.localRunnerID];
//                } completHandler:^{
//                    if(model.isUp) {
//                        [[YDFitnessDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                            _fitnessModel = [YDFitnessDayDetailSportTable db:db selectDayDetailSportStatusWithLocalRunnerID:_runnerModel.localRunnerID];
//                        } completHandler:^{
//                            if (_fitnessModel && _fitnessModel.status == YDFitnessDayDetailModelStatusFinish) {
//                                _fitnessModel.runnerID = dic[@"runner_id"];
//                                [[YDFitnessDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                                    [YDFitnessDayDetailSportTable db:db updateDayDetailSportStatusWithLocalRunnerID:_runnerModel.localRunnerID andStatus:YDFitnessDayDetailModelStatusFinish andRunnerID:_fitnessModel.runnerID];
//                                } completHandler:^{
//                                    [self reportFitnessInfo];
//                                }];
//                            }else{
//                                [self uploadRunnerDataWithCompletion:nil];
//                            }
//                        }];
//                    }
//                }];
//            }
//        } else {
//
//            if (br.error.httpError != MSHttpErrorNet && br.error.httpError != MSHttpErrorServerError && br.error.httpError != MSHttpErrorTokenTimeout && br.error.httpError != MSHttpErrorCanceled) {
//
//            }
//        }
//    }
}

- (void)msReportRunnerPathDataFinished: (NSNotification *)notification {
//    MSBaseResult *br = notification.object;
//    if (br.mid == 1) {
//        if (br.success) {
//            _runnerModel.isUp=YES;
//            _runnerModel.isGetRunner=YES;
//            __block YDRunModel *model;
//            [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                [YDDBTable db:db updateRunnerFromDataBase:_runnerModel andLocalRunnerID:_runnerModel.localRunnerID];
//                model = [YDDBTable db:db selectRunnerFromDataBaseForLocalRunnerID:_runnerModel.localRunnerID];
//            } completHandler:^{
//                if(model.isUp)
//                {
//                    [self uploadRunnerDataWithCompletion:nil];
//                }
//            }];
//        } else {
//
//            if (br.error.httpError != MSHttpErrorNet && br.error.httpError != MSHttpErrorServerError && br.error.httpError != MSHttpErrorTokenTimeout && br.error.httpError != MSHttpErrorCanceled) {
//
//            }
//        }
//
//    }
}

- (void)msReportRunnerInfoBraceletFinished: (NSNotification *)notification {
//    MSBaseResult *br = notification.object;
//    if (br.mid == 4) {
//        if (br.success) {
//            NSDictionary *dic = br.data;
//            _braceletDayModel.isUp = YES;
//            _braceletDayModel.runnerID = dic[@"runner_id"];
//            __block YDBraceletDayModel *model;
//            [[YDDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                [YDDBTable db:db updateBraceletDayRecordWithModel:_braceletDayModel andSyncId:_braceletDayModel.syncID];
//                 model = [YDDBTable db:db selectBraceletDayRecordFromDataBaseForSyncId:_braceletDayModel.syncID];
//            } completHandler:^{
//                if(model.isUp)//校验更新成功
//                {
//                    [self uploadBraceletDayDataWithCompletion:nil];
//                }
//            }];
//        } else {
//            if (br.error.httpError != MSHttpErrorNet && br.error.httpError != MSHttpErrorServerError && br.error.httpError != MSHttpErrorTokenTimeout && br.error.httpError != MSHttpErrorCanceled) {
//
//            } else {
//            }
//        }
//    }
    
}

- (void)reportFitnessInfo {
//    _reportFitnessUUID = [MSAFHttpKit generateUUID];
//    NSDictionary *params = [YDDataSolver reportFitnessWithUserID:_fitnessModel.userID
//                                                       fitnessID:_fitnessModel.fitnessID
//                                                        dayIndex:_fitnessModel.dayIndex
//                                                        runnerID:_fitnessModel.runnerID
//                                                        costTime:_runnerModel.costTime
//                                                        distance:_runnerModel.distance];
//    [[YDUserInstance fitnessMgr] reportFitnessWithBlock:NULL andParam:params andUUID:_reportFitnessUUID];
}

- (void)msReportFitnessFinished :(NSNotification *)notification {
//    MSBaseResult *br = notification.object;
//    if ([br.uuid isEqualToString:_reportFitnessUUID]) {
//        if (br.success) {
//            _fitnessModel.status = YDFitnessDayDetailModelStatusReport;
//            [[YDFitnessDB sharedDb] inAsyncMainDatabase:^(FMDatabase *db) {
//                [YDFitnessDayDetailSportTable db:db updateDayDetailSportStatusWithLocalRunnerID:_runnerModel.localRunnerID andStatus:YDFitnessDayDetailModelStatusReport andRunnerID:nil];
//            } completHandler:^{
//                [self uploadRunnerDataWithCompletion:nil];
//            }];
//        }
//    }
}

@end
