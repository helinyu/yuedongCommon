//
//  YDS3ViewController.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDS3ViewController.h"
#import "YDBlueToothMgr.h"
#import "YDS3PeriipheralsViewController.h"
#import "YDS3MainView.h"
#import "YDS3Mgr.h"
#import "YDPeripheralModel.h"
#import "PeripheralsModelMgr.h"


@interface YDS3ViewController ()

@property (nonatomic, strong) YDBlueToothMgr *mgr;
@property (nonatomic, strong) YDS3Mgr *s3Mgr;

@property (nonatomic, strong) YDS3MainView * infoView;

//mark -- test for model
@property (nonatomic, strong) PeripheralsModelMgr *modelMgr;
@property (nonatomic, strong) YDPeripheralsModel *modelItems;
@property (nonatomic, strong) YDPeripheralModel *currentPeripheralModelItem;

@end

@implementation YDS3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _infoView = [[YDS3MainView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_infoView];

    _mgr = [YDBlueToothMgr shared];
    [self peripheralModelInit];
    [self onStartClicked];
//    [self datasFeed];
    [self dataS3Feed];
}

- (void)peripheralModelInit {
    _modelMgr = PeripheralsModelMgr.shareAndChain().loadPeripheralModel(nil);
    YDPeripheralModel *peripheralModeltem = [_modelMgr specifyPeripheralWithName:@"S3"];
    _currentPeripheralModelItem = peripheralModeltem;
    NSLog(@"");
}

- (void)dataS3Feed {
    _s3Mgr = [YDS3Mgr shared];
    __weak typeof (self) wSelf = self;
    _mgr.characteristicCallBack = ^(CBCharacteristic *c) {
        [wSelf.s3Mgr insertDataToYDOpen:c];
        wSelf.s3Mgr.tripCallBack = ^(CGFloat calories, CGFloat distance) {
            dispatch_async(dispatch_get_main_queue(), ^{
                wSelf.infoView.calorieNumLabel.text = [NSString stringWithFormat:@"%f",calories];
                wSelf.infoView.distanceNumLabel.text = [NSString stringWithFormat:@"%f",distance];
            });
        };
        wSelf.s3Mgr.heartRateCallBack = ^(NSString *heartString) {
            dispatch_async(dispatch_get_main_queue(), ^{
                wSelf.infoView.heartRateNumLabel.text = [NSString stringWithFormat:@"%@",heartString];
            });
        };
    };

}

- (void)datasFeed {
    __weak typeof (self) wSelf = self;
    _mgr.tripCallBack = ^(CGFloat calories, CGFloat distance) {
        NSLog(@"calories : %f",calories);
        NSLog(@"distance : %f",distance);
        dispatch_async(dispatch_get_main_queue(), ^{
            wSelf.infoView.calorieNumLabel.text = [NSString stringWithFormat:@"%f",calories];
            wSelf.infoView.distanceNumLabel.text = [NSString stringWithFormat:@"%f",distance];
        });
    };
    
    _mgr.heartRateCallBack = ^(NSString *heartString) {
        NSLog(@"heateRateing : %@",heartString);
        dispatch_async(dispatch_get_main_queue(), ^{
            wSelf.infoView.heartRateNumLabel.text = [NSString stringWithFormat:@"%@",heartString];
        });
    };
}

- (void)onStartClicked {
    __weak typeof (self) wSelf = self;
    _infoView.onBtnActionClicked = ^(YDActionType type) {
        switch (type) {
            case YDActionTypePeripheralList:
            {
                YDS3PeriipheralsViewController *vc = [YDS3PeriipheralsViewController new];
                [wSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case YDActionTypeStartBtn:
            {
                [wSelf.mgr startScan];
                wSelf.mgr.connectionCallBack = ^(BOOL success) {
                    if (success) {
//                        [wSelf.mgr ] readvalue
//                        feed datas
                    }
                };
            }
                break;
                
            default:
                break;
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
