//
//  YDAvatarCCell.m
//  TestCircleAk03
//
//  Created by Aka on 2017/11/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDAvatarCCell.h"
#import "Masonry.h"

@interface YDAvatarCCell ()

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *iconImgView;

@property (nonatomic, assign) BOOL hasInit;

@end

@implementation YDAvatarCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_hasInit) {
            [self baseInit];
        }
    }
    return self;
}

- (void)baseInit {
    _avatarView = [UIImageView new];
    [self addSubview:_avatarView];
    
    _iconImgView = [UIImageView new];
    [self addSubview:_iconImgView];
    
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.width.height.mas_equalTo(10.f);
    }];
}

- (void)setFrame:(CGRect)frame {
    if (!_hasInit) {
        [self baseInit];
    }
    
    _avatarView.layer.cornerRadius  = CGRectGetWidth(frame)/2.f;
    [_avatarView clipsToBounds];
    
    _iconImgView.layer.cornerRadius = 5.f;
    [_iconImgView clipsToBounds];
}

- (void)configureWithAvatar:(NSString *)avatarString sex:(BOOL)sex {
    _avatarView.image = [UIImage imageNamed:avatarString];
    if (sex) {
        _iconImgView.image = [UIImage imageNamed:@""];
    }
    else {
        _iconImgView.image = [UIImage imageNamed:@""];
    }
}

@end
