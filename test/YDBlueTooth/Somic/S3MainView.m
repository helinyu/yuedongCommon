//
//  S3MainView.m
//  YDOpenHardwareThirdPart
//
//  Created by mac-somic on 2017/4/16.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "S3MainView.h"
#import "UIView+Frame.h"


@interface S3MainView ()<UIScrollViewDelegate>
{
    NSString *dateTime;
}

@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIButton *bluethBtn;

@property (nonatomic, strong) UIButton *dayRightBtn;

@property (nonatomic, strong) UIImageView *stepMidIV;
@property (nonatomic, strong) UIImageView *footMidIV;

@property (nonatomic, strong) UIImageView *heatRateIV;
@property (nonatomic, strong) UIImageView *hotIV;
@property (nonatomic, strong) UIImageView *distanceIV;
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation S3MainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.scrollV.delegate = self;
    [self addSubview:self.scrollV];
    
    self.bluethBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
    
    [self.bluethBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"SOMICS3ICON.bundle/somic_bluetooth"]] forState:UIControlStateNormal];
    
    [self.bluethBtn addTarget:self action:@selector(bluethBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollV addSubview:self.bluethBtn];
    
    self.dayMidLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-60, 30, 120, 20)];
    self.dayMidLab.textColor = RGB(28, 192, 25);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateTime = [formatter stringFromDate:[NSDate date]];
    self.dayMidLab.text = dateTime;
    self.dayMidLab.textAlignment = NSTextAlignmentCenter;
    [self.scrollV addSubview:self.dayMidLab];
    
    self.dayRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-20, 20, 40, 40)];
    [self.dayRightBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"SOMICS3ICON.bundle/somic_calendar"]] forState:UIControlStateNormal];
    [self.dayRightBtn addTarget:self action:@selector(dayRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollV addSubview:self.dayRightBtn];
    
    self.todayMidLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, self.dayMidLab.bottom+20, 80, 20)];
    self.todayMidLab.textColor = [UIColor whiteColor];
    self.todayMidLab.text = @"今天";
    self.todayMidLab.textAlignment = NSTextAlignmentCenter;
    [self.scrollV addSubview:self.todayMidLab];
    
    self.stepMidIV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, self.todayMidLab.bottom+10, 200, 200)];
    [self.stepMidIV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"SOMICS3ICON.bundle/somic_step_bg"]]];
    [self.scrollV addSubview:self.stepMidIV];
    
    self.footMidIV = [[UIImageView alloc]initWithFrame:CGRectMake(200/2-46/2, 200/2-71/2, 46, 71)];
    [self.footMidIV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"SOMICS3ICON.bundle/somic_foot"]]];
    [self.stepMidIV addSubview:self.footMidIV];
    
    self.stepNumLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-80, self.stepMidIV.bottom-40, 160, 20)];
    self.stepNumLab.textColor = [UIColor whiteColor];
    self.stepNumLab.text = @"0";
    self.stepNumLab.textAlignment = NSTextAlignmentCenter;
    [self.scrollV addSubview:self.stepNumLab];
    
    self.heatRateIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.stepMidIV.bottom+20, 72, 68)];
    [self.heatRateIV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"SOMICS3ICON.bundle/somic_heart_rate"]]];
    [self.scrollV addSubview:self.heatRateIV];
    
    self.hotIV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-36, self.stepMidIV.bottom+20, 72, 68)];
    [self.hotIV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"SOMICS3ICON.bundle/somic_ka"]]];
    [self.scrollV addSubview:self.hotIV];
    
    self.distanceIV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-72, self.stepMidIV.bottom+20, 72, 68)];
    [self.distanceIV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"SOMICS3ICON.bundle/somic_distance"]]];
    [self.scrollV addSubview:self.distanceIV];
    
    self.heatRateLab = [[UILabel alloc]initWithFrame:CGRectMake(20, self.heatRateIV.bottom+10, 80, 20)];
    self.heatRateLab.textColor = [UIColor whiteColor];
    self.heatRateLab.textAlignment = NSTextAlignmentCenter;
    self.heatRateLab.text = @"0";
    [self.scrollV addSubview:self.heatRateLab];
    
    self.hotLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, self.hotIV.bottom+10, 80, 20)];
    self.hotLab.textColor = [UIColor whiteColor];
    self.hotLab.textAlignment = NSTextAlignmentCenter;
    self.hotLab.text = @"0";
    [self.scrollV addSubview:self.hotLab];
    
    self.distanceLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-80, self.distanceIV.bottom+10, 80, 20)];
    self.distanceLab.textColor = [UIColor whiteColor];
    self.distanceLab.textAlignment = NSTextAlignmentCenter;
    self.distanceLab.text = @"0";
    [self.scrollV addSubview:self.distanceLab];
    
    self.startBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, self.hotLab.bottom+2, 80, 40)];
    [self.startBtn setBackgroundColor:RGB(28, 192, 25)];
    self.startBtn.layer.masksToBounds = YES;
    self.startBtn.layer.cornerRadius = 10.0;
    [self.startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.startBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self.startBtn addTarget:self action:@selector(startBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollV addSubview:self.startBtn];
    
    CGFloat heightScrol = self.startBtn.bottom+30;
    self.scrollV.contentSize = CGSizeMake(SCREEN_WIDTH, heightScrol);
}

#pragma mark -- button click
- (void)bluethBtnAction{// 搜索设备
    if (self.delegate && [self.delegate respondsToSelector:@selector(blueBtnSearchClick)]) {
        [self.delegate blueBtnSearchClick];
    }
}
- (void)dayRightBtnAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dayRightSearch)]) {
        [self.delegate dayRightSearch];
    }
}
- (void)startBtnAction{// 连接
    if (self.delegate && [self.delegate respondsToSelector:@selector(blueStartRun)]) {
        [self.delegate blueStartRun];
    }
}

@end
