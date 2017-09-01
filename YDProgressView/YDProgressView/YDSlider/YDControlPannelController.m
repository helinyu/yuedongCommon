
//
//  YDControlPannelController.m
//  SportsBar
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import "YDControlPannelController.h"
#import "YDSlider.h"
#import "Masonry.h"
#import "YYImage.h"

@interface YDControlPannelController ()

@property (nonatomic, strong) YDSlider *progressSlider;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *leftPreviousLabel;
@property (nonatomic, strong) UILabel *rightNextLabel;

@property (nonatomic, strong) UIButton *previousBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *playOrPauseBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation YDControlPannelController

- (void)viewDidLoad {
    [super viewDidLoad];

    _progressSlider = [YDSlider new];
    _progressSlider.ydSupperView(self.view).ydMinimumTrackTintColor([UIColor greenColor]).ydMaximumTrackTintColor([UIColor grayColor]).ydThumbTintColor([UIColor greenColor]);
    [_progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(62.f);
        make.centerY.equalTo(self.view).offset(-9);
        make.height.mas_equalTo(10.f);
        make.right.equalTo(self.view).offset(-62);
    }];
     
     
     _titleLabel = [UILabel new];
     [self.view addSubview:_titleLabel];
    _titleLabel.text = @"3o天训练跑";
    _titleLabel.textColor = [UIColor darkGrayColor]; // need to change the text color
    [_titleLabel setFont:[UIFont fontWithName:@"SFNSText-Regular" size:16]];
    [_titleLabel sizeToFit];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(32);
        make.centerX.equalTo(self.view);
    }];
    
    _leftPreviousLabel = [UILabel new];
    [self.view addSubview:_leftPreviousLabel];
    _leftPreviousLabel.text = @"0:00";
    [_leftPreviousLabel setFont:[UIFont fontWithName:@"AppleSystemUIFont" size:12.f]];
    [_leftPreviousLabel sizeToFit];
    [_leftPreviousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(14.f);
        make.centerY.equalTo(_progressSlider);
    }];
    
    _rightNextLabel = [UILabel new];
    [self.view addSubview:_rightNextLabel];
    _rightNextLabel.text = @"-3:21";
    [_rightNextLabel setFont:[UIFont fontWithName:@"AppleSystemUIFont" size:12.f]];
    [_rightNextLabel sizeToFit];
    [_rightNextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-14.f);
        make.centerY.equalTo(_progressSlider);
    }];
    
    
    _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playOrPauseBtn setImage:[UIImage imageNamed:@"icon_audio_play"] forState:UIControlStateNormal];
    [_playOrPauseBtn addTarget:self action:@selector(onPlayOrPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playOrPauseBtn];
    [_playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    
    
    _previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_previousBtn setImage:[UIImage imageNamed:@"icon_audio_previous"] forState:UIControlStateNormal];
    [_previousBtn addTarget:self action:@selector(onPreviousClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_previousBtn];
    [_previousBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18.f);
        make.right.equalTo(_playOrPauseBtn).offset(-50.f);
        make.centerY.equalTo(_playOrPauseBtn);
    }];

    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setImage:[UIImage imageNamed:@"icon_audio_next"] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18.f);
        make.left.equalTo(_playOrPauseBtn).offset(50.f);
        make.centerY.equalTo(_playOrPauseBtn);
    }];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"icon_audio_close"] forState:UIControlStateNormal];
    [self.view addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18.f);
        make.centerY.equalTo(_playOrPauseBtn);
        make.right.equalTo(self.view).offset(-30);
    }];
    
}

- (void)onPreviousClick {
    NSLog(@"上一首");
}

- (void)onNextClick {
    NSLog(@"下一首");
}

- (void)onPlayOrPause {
    NSLog(@"播放/暂停");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -- block of the property 

- (YDControlPannelController *(^)(NSString *title))controlPanelTitle {
    return ^(NSString *title) {
        _titleLabel.text = title;
        return self;
    };
}

- (YDControlPannelController *(^)(NSInteger currentTime))controlPanelCurrentTime {
    return ^(NSInteger currentTime) {
        
        return self;
//        将时间转化规定的格式
    };
}

- (YDControlPannelController *(^)(NSInteger leaveTime))controlPanelLeaveTime {
    return ^(NSInteger leaveTime) {
        return self;
    };
}

- (YDControlPannelController *(^)(NSInteger totalTime))controlPanelTotalTime {
    return ^(NSInteger totalTime) {
        return self;
    };
}


- (YDControlPannelController *(^)(void))controlPanelNext {
    return ^(void) {
//        to the next track
        return self;
    };
}

- (YDControlPannelController *(^)(void))controlPanelPrevious {
    return ^(void) {
        return self;
    };
}

- (YDControlPannelController *(^)(CGFloat progress))controlPanelProgress {
    return ^(CGFloat progress) {
        return self;
    };
}


@end
