//
//  HLYAudioView.m
//  test
//
//  Created by felix on 2017/6/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYAudioView.h"

@interface HLYAudioView ()

@property (nonatomic, strong) UIButton *playerBtn;

@end

static const NSInteger playBtnWidth = 30.f;
static const NSInteger playBtnHeight = playBtnWidth;

@implementation HLYAudioView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
        [self styleInit];
        [self langInit];
    }
    return self;
}

- (void)comInit {
    
    if (!_playerBtn) {
        _playerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_playerBtn];
        [_playerBtn addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self createConstraints];
}

- (void)createConstraints {
    [self.playerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-20);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(playBtnWidth);
    }];
}

- (void)styleInit {
    _playerBtn.backgroundColor = [UIColor blueColor];
}

- (void)langInit {
    [_playerBtn setImage:[UIImage imageNamed:@"icon_run_start_player"] forState:UIControlStateNormal];
    [_playerBtn sizeToFit];
}

- (void)onClicked:(UIButton *)sender {
    !_playBlock?:_playBlock();
}


@end
