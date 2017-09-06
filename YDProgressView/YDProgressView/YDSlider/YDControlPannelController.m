
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

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *leftPreviousLabel;
@property (nonatomic, strong) UILabel *rightNextLabel;

@property (nonatomic, strong) UIButton *previousBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *playOrPauseBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) NSTimeInterval currentTime;

@property (nonatomic, strong) UIButton *putAwayBtn;

@end

@implementation YDControlPannelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 153)];
    [self.view addSubview:_containerView];
    _containerView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor yellowColor];
    _progressSlider = [YDAudioSlider new];
    _progressSlider.ydSupperView(_containerView).ydFrame(CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 20)).ydMinimumTrackTintColor([UIColor greenColor]).ydMaximumTrackTintColor([UIColor grayColor]).customThumbImageWithName(@"icon_audio_hover_btn",CGSizeMake(15, 15));
    [_progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView).offset(62.f);
        make.centerY.equalTo(_containerView).offset(-9);
        make.height.mas_equalTo(10.f);
        make.right.equalTo(_containerView).offset(-70);
    }];
    
    _titleLabel = [UILabel new];
    [_containerView addSubview:_titleLabel];
    _titleLabel.text = @"";
    _titleLabel.textColor = [UIColor darkGrayColor];
    [_titleLabel setFont:[UIFont fontWithName:@"SFNSText-Regular" size:16]];
    [_titleLabel sizeToFit];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(32);
        make.centerX.equalTo(_containerView);
    }];
    _titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTitleClick:)];
    [_titleLabel addGestureRecognizer:tapRecognizer];
    
    _leftPreviousLabel = [UILabel new];
    [_containerView addSubview:_leftPreviousLabel];
    _leftPreviousLabel.text = @"0:00";
    [_leftPreviousLabel setFont:[UIFont fontWithName:@"AppleSystemUIFont" size:12.f]];
    [_leftPreviousLabel sizeToFit];
    [_leftPreviousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView).offset(14.f);
        make.centerY.equalTo(_progressSlider);
    }];
    
    _rightNextLabel = [UILabel new];
    [_containerView addSubview:_rightNextLabel];
    _rightNextLabel.text = @"-3:21";
    [_rightNextLabel setFont:[UIFont fontWithName:@"AppleSystemUIFont" size:12.f]];
    [_rightNextLabel sizeToFit];
    [_rightNextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_containerView).offset(-14.f);
        make.centerY.equalTo(_progressSlider);
    }];
    
    
    _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playOrPauseBtn setImage:[UIImage imageNamed:@"icon_audio_play"] forState:UIControlStateNormal];
    [_playOrPauseBtn addTarget:self action:@selector(onPlayOrPause) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_playOrPauseBtn];
    [_playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView);
        make.bottom.equalTo(_containerView).offset(-20);
    }];
    
    _previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_previousBtn setImage:[UIImage imageNamed:@"icon_audio_previous"] forState:UIControlStateNormal];
    [_previousBtn addTarget:self action:@selector(onPreviousClick) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_previousBtn];
    [_previousBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(18.f);
        make.right.equalTo(_playOrPauseBtn).offset(-50.f);
        make.centerY.equalTo(_playOrPauseBtn);
    }];

    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setImage:[UIImage imageNamed:@"icon_audio_next"] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(18.f);
        make.left.equalTo(_playOrPauseBtn).offset(50.f);
        make.centerY.equalTo(_playOrPauseBtn);
    }];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setTitle:@"结束播放" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.f]; // 字体颜色333333
    [_closeBtn addTarget:self action:@selector(onCloseClick) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_playOrPauseBtn);
        make.right.equalTo(_containerView).offset(-14.f);
    }];
    
    _putAwayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_putAwayBtn setTitle:@"收起" forState:UIControlStateNormal];
    [_putAwayBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    _putAwayBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.f]; // 字体颜色333333
    [_putAwayBtn addTarget:self action:@selector(onPutAwayClick) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_putAwayBtn];
    [_putAwayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_playOrPauseBtn);
        make.left.equalTo(_containerView).offset(20.f);
    }];

}

#pragma mark --- nomal custom methods

- (void)onCloseClick {
    NSLog(@"close ");
    !_closeBlock?:_closeBlock();
}

- (void)onPutAwayClick {
    NSLog(@"put away");
    !_putAwayBlock?:_putAwayBlock();
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

- (void)onTitleClick:(UITapGestureRecognizer *)recognizer {
    NSLog(@"tap gesture");
    !_titleTapBlock?:_titleTapBlock();
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
        
        wSelf.leftPreviousLabel.text = [NSString stringWithFormat:@"%@",[self _toFormatTimeWithSeconds:wSelf.currentTime]];
        NSInteger leaveTime = wSelf.totalTime - _currentTime;
        wSelf.rightNextLabel.text = [NSString stringWithFormat:@"-%@",[self _toFormatTimeWithSeconds:leaveTime]];
        float progress = wSelf.currentTime/wSelf.totalTime;
        [wSelf.progressSlider setValue:progress animated:YES];
        return self;
    };
}

- (NSString *)_toFormatTimeWithSeconds:(NSInteger)seconds {
    NSInteger second = seconds % 60;
    NSInteger minutes = seconds / 60;
    if (seconds < 60*60) {
        return [NSString stringWithFormat:@"%02d:%02d",minutes,second];
    }
    
    if (seconds > 60 * 60) {
        NSInteger hour = minutes / 60;
        NSInteger minute = seconds % 60;
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];
    }
    
    return nil;
}

@end
