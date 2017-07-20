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

@interface YDS3ViewController ()

@property (nonatomic, strong) YDBlueToothMgr *mgr;

@property (nonatomic, strong) YDS3MainView * infoView;

@end

@implementation YDS3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _infoView = [[YDS3MainView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_infoView];

    _mgr = [YDBlueToothMgr shared];
    [self onStartClicked];
    [self datasFeed];
}

- (void)datasFeed {
    __weak typeof (self) wSelf = self;
    _mgr.tripCallBack = ^(CGFloat calories, CGFloat distance) {
        NSLog(@"calories : %f",calories);
        NSLog(@"distance : %f",calories);
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
