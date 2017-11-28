//
//  YDDynamicDetailHeaderView.m
//  TestCircleAk03
//
//  Created by Aka on 2017/11/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDDynamicDetailHeaderView.h"
#import "Masonry.h"

#import "YDTitleCollecitonView.h"
#import "YYLabel.h"

@interface YDDynamicDetailHeaderView ()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) YYLabel *nickLabel;
@property (nonatomic, strong) YYLabel *timeLabel;
@property (nonatomic, strong) UIButton *followBtn;

@property (nonatomic, strong) UIView *textWarpperView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *addressView;
@property (nonatomic, strong) UIImageView *addressIconView;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) YDTitleCollecitonView *titleCollectionView;

@property (nonatomic, strong) UIView *commentNumWrapperView;
@property (nonatomic, strong) UILabel *commentNumLabel;

@end

@implementation YDDynamicDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInitWithFrame:frame];
    }
    return self;
}

- (void)baseInitWithFrame:(CGRect)frame {
    {
        _avatarView = [UIImageView new];
        [self addSubview:_avatarView];
        
        _iconView = [UIImageView new];
        [self addSubview:_iconView];
        
        _nickLabel = [YYLabel new];
        [self addSubview:_nickLabel];
        
        _timeLabel = [YYLabel new];
        [self addSubview:_timeLabel];
        
        _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_followBtn];
    }
    
    {
        [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(14.f);
            make.top.equalTo(self).offset(16.f);
            make.height.width.mas_equalTo(40.f);
        }];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(_avatarView);
            make.height.width.mas_equalTo(12.f);
        }];
        
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarView.mas_right).offset(10.f);
            make.top.equalTo(_avatarView);
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarView.mas_right).offset(10.f);
            make.bottom.equalTo(_avatarView);
        }];
        
        [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-14.f);
            make.centerY.equalTo(_avatarView);
        }];
        
    }
    
//     default text
    {
        [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
    
//    style
    {
        self.backgroundColor = [UIColor colorWithRed:248.f/255.f green:248.f/255.f blue:248.f/255.f alpha:1.f];
        
        _avatarView.layer.cornerRadius = 20.f;
        _avatarView.layer.masksToBounds =  YES;
        
        _iconView.layer.cornerRadius = 6.f;
        _iconView.layer.masksToBounds = YES;
    }
    
//    bind action
    {
        [_followBtn addTarget:self action:@selector(onFollowClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)onFollowClick:(id)sender {
    !_followBlock? :_followBlock(1);
}

@end
