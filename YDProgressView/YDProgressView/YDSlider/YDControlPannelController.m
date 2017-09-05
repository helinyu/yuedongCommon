
//
//  YDControlPannelController.m
//  SportsBar
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import "YDControlPannelController.h"
#import "YDAudioSlider.h"
#import "Masonry.h"
#import "YYImage.h"

@interface YDControlPannelController ()

@property (nonatomic, strong) YDAudioSlider *progressSlider;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *leftPreviousLabel;
@property (nonatomic, strong) UILabel *rightNextLabel;

@property (nonatomic, strong) UIButton *previousBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *playOrPauseBtn;
@property (nonatomic, strong) UIButton *closeBtn;


@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) NSTimeInterval currentTime;

@end

@implementation YDControlPannelController

- (void)viewDidLoad {
    [super viewDidLoad];

    _progressSlider = [YDAudioSlider new];
    _progressSlider.ydSupperView(self.view).ydFrame(CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 20)).ydMinimumTrackTintColor([UIColor greenColor]).ydMaximumTrackTintColor([UIColor grayColor]).customThumbImageWithName(@"icon_audio_hover_btn",CGSizeMake(15, 15));
//    [_progressSlider addTarget:self action:@selector(onChangeProgressClick:) forControlEvents:UIControlEventValueChanged];
    [_progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(62.f);
        make.centerY.equalTo(self.view).offset(-9);
        make.height.mas_equalTo(10.f);
        make.right.equalTo(self.view).offset(-62);
    }];
    
    _titleLabel = [UILabel new];
    [self.view addSubview:_titleLabel];
    _titleLabel.text = @"3o天训练跑";
    _titleLabel.textColor = [UIColor darkGrayColor]; // need to change the text color 333333
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
    [_closeBtn setTitle:@"结束播放" forState:UIControlStateNormal];
    [_closeBtn sizeToFit];
    [_closeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.f]; // 字体颜色333333
    [_closeBtn addTarget:self action:@selector(onCloseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18.f);
        make.centerY.equalTo(_playOrPauseBtn);
        make.right.equalTo(self.view).offset(-14.f);
    }];
    
}

- (void)onCloseClick {
    NSLog(@"close ");
    !_closeBlock?:_closeBlock();
}

- (void)onPreviousClick {
    !_previousBlock?:_previousBlock();
}

- (void)onNextClick {
    !_nextBlock?:_nextBlock();
}

- (void)onPlayOrPause {
    !_playOrPauseBlock?:_playOrPauseBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (void)onChangeProgressClick:(UISlider *)slider {
//    NSLog(@"slider value : %f",slider.value);
//    !_changeValueBlock?:_changeValueBlock(slider.value);
//}

#pragma mark --- nomal custom methods



#pragma mark -- block of the property 

- (YDControlPannelController *(^)(NSString *title))controlPanelTitle {
    return ^(NSString *title) {
        _titleLabel.text = title;
        return self;
    };
}

- (YDControlPannelController *(^)(NSTimeInterval currentTime))controlPanelCurrentTime {
    __weak typeof (self) wSelf = self;
    return ^(NSTimeInterval currentTime) {
//        wSelf.leftPreviousLabel.text = [NSString stringWithFormat:@"%d",(NSInteger)currentTime];
        wSelf.currentTime = currentTime;
           return self;
    };
}

- (YDControlPannelController *(^)(NSTimeInterval totalTime))controlPanelTotalTime {
    __weak typeof (self) wSelf = self;
    return ^(NSTimeInterval totalTime) {
        wSelf.totalTime = totalTime;
        return self;
    };
}

- (YDControlPannelController *(^)(BOOL isPlaying))updatePlayOrPause {
    __weak typeof (self) wSelf = self;
    return ^(BOOL isPlaying) {
        if (isPlaying) {
            [wSelf.playOrPauseBtn setImage:[UIImage imageNamed:@"icon_audio_stop"] forState:UIControlStateNormal];
            //            启动计时器
        }else{
            [wSelf.playOrPauseBtn setImage:[UIImage imageNamed:@"icon_audio_play"] forState:UIControlStateNormal];
        }
        return self;
    };
}

- (YDControlPannelController *(^)(void))updateView {
    __weak typeof (self) wSelf = self;
    return ^(void) {
        wSelf.updateProgressView().updatePlayOrPause(YES);
        return self;
    };
}

- (YDControlPannelController *(^)(void))updateProgressView {
    __weak typeof (self) wSelf = self;
    return ^(void) {
        if (wSelf.totalTime <= 0.0) {
            NSLog(@"请先传入总的时间");
            return self;
        }
        
        wSelf.leftPreviousLabel.text = [NSString stringWithFormat:@"%d",(NSInteger)wSelf.currentTime];
        NSInteger leaveTime = wSelf.totalTime - _currentTime;
        wSelf.rightNextLabel.text = [NSString stringWithFormat:@"-%d",leaveTime];
        float progress = wSelf.currentTime/wSelf.totalTime;
        [wSelf.progressSlider setValue:progress animated:YES];
        return self;
    };
}

@end
