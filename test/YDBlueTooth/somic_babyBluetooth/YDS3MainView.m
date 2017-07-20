//
//  YDS3MainView.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDS3MainView.h"
#import "Masonry.h"

@implementation YDS3MainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
        [self langInit];
        [self bindInit];
        [self createContraints];
    }
    return self;
}

- (void)comInit {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _turnPeripheralListBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_turnPeripheralListBtn];
    
    _startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_startBtn];
    
    _heartRateTitleLabel = [UILabel new];
    [self addSubview:_heartRateTitleLabel];
    
    _heartRateNumLabel = [UILabel new];
    [self addSubview:_heartRateNumLabel];
    
    _calorieTitleLabel = [UILabel new];
    [self addSubview:_calorieTitleLabel];
    
    _calorieNumLabel = [UILabel new];
    [self addSubview:_calorieNumLabel];
    
    _distancetitleLabel = [UILabel new];
    [self addSubview:_distancetitleLabel];
    
    _distanceNumLabel = [UILabel new];
    [self addSubview:_distanceNumLabel];
    
}

- (void)createContraints {
    
    [_turnPeripheralListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(80);
    }];
    
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(_turnPeripheralListBtn);
    }];
    
    [_heartRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(140);
    }];
    [_heartRateNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_heartRateTitleLabel);
        make.top.equalTo(_heartRateTitleLabel.mas_bottom);
    }];
    
    [_calorieTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_heartRateTitleLabel);
    }];
    [_calorieNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_calorieTitleLabel.mas_bottom);
    }];
    
    [_distancetitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(_heartRateTitleLabel);
    }];
    [_distanceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_distancetitleLabel);
        make.top.equalTo(_distancetitleLabel.mas_bottom);
    }];
    
}

- (void)bindInit {
    [_turnPeripheralListBtn addTarget:self action:@selector(onTurnToPeripheralListClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_startBtn addTarget:self action:@selector(onStartClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)langInit {
    [_turnPeripheralListBtn setTitle:@"蓝牙设备查找列表" forState:UIControlStateNormal];
    [_turnPeripheralListBtn sizeToFit];
    [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_startBtn sizeToFit];
    _heartRateTitleLabel.text = @"心率/秒";
    _heartRateNumLabel.text = @"0";
    _calorieTitleLabel.text = @"卡路里/卡";
    _calorieNumLabel.text = @"0";
    _distancetitleLabel.text = @"距离/千米";
    _distanceNumLabel.text = @"0";
    
}

- (void)onTurnToPeripheralListClicked:(UIButton *)sender {
    !_onBtnActionClicked?:_onBtnActionClicked(YDActionTypePeripheralList);
}

- (void)onStartClicked:(UIButton *)sender {
    !_onBtnActionClicked?:_onBtnActionClicked(YDActionTypeStartBtn);
}

@end
