//
//  S3MainView.h
//  YDOpenHardwareThirdPart
//
//  Created by mac-somic on 2017/4/16.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluetoothDaterView.h"

@protocol S3MainViewDelegate <NSObject>

- (void)blueBtnSearchClick;
- (void)dayRightSearch;
- (void)blueStartRun;

@end
@interface S3MainView : UIView

@property (nonatomic, strong) BluetoothDaterView *dater;
@property (nonatomic, strong) UILabel *dayMidLab;
@property (nonatomic, strong) UILabel *todayMidLab;
@property (nonatomic, strong) UILabel *stepNumLab;
@property (nonatomic, strong) UILabel *heatRateLab;
@property (nonatomic, strong) UILabel *hotLab;
@property (nonatomic, strong) UILabel *distanceLab;
@property (nonatomic, weak) id<S3MainViewDelegate> delegate;

@end
