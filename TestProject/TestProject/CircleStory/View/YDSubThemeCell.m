//
//  YDSubThemeCell.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDSubThemeCell.h"
#import "YDCircleSubThemeModel.h"
#import <UIImageView+WebCache.h>

static const CGFloat kContainerRight = -6;
static const CGFloat kLeftViewWidth = 6;
static const CGFloat kTypeImageViewTop = 7;
static const CGFloat kTypeImageViewRight = -6;
static const CGFloat kTypeImageViewWidth = 121;
static const CGFloat kTypeImageViewHeight = 98;
static const CGFloat kTitleLabelTop = 20;
static const CGFloat kTitleLabelRight = -20;
static const CGFloat kTitleLabelLeft = 20;
static const CGFloat kRecommenTitleLabelTop = 6.f;
static const CGFloat kRecommenTitleLabelRight = -16.f;
static const CGFloat kSubTitleLabelBottom = -14.f;

@interface YDSubThemeCell ()
@property (nonatomic,   weak) UIView *containerView;
@property (nonatomic,   weak) UIView *leftView;
@property (nonatomic,   weak) UILabel *titleLabel;
@property (nonatomic,   weak) UILabel *recommenTitleLabel;
@property (nonatomic,   weak) UILabel *subTitleLabel;
@property (nonatomic,   weak) UIImageView *typeImageView;
@end

@implementation YDSubThemeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        [self styleInit];
    }
    return self;
}

- (void)setSubThemeModel:(YDCircleSubThemeModel *)subThemeModel {
    _subThemeModel = subThemeModel;
    self.titleLabel.text = MSLocalizedString(subThemeModel.subThemeTitle, nil);
    self.recommenTitleLabel.text = [NSString stringWithFormat:@"最新：%@",subThemeModel.recommendTitle];
    self.subTitleLabel.text = MSLocalizedString(subThemeModel.subThemeNumStr, nil);
    [self.typeImageView sd_setImageWithURL:[NSURL yd_URLWithString:subThemeModel.subThemeIconUrl] placeholderImage:[UIImage imageNamed:@"img_origin_circle_topic_placeholder_small.jpg"]];
}
- (void)addSubviews {
    if (self.containerView == nil) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.containerView = view;
    }
    if (self.leftView == nil) {
        UIView *view = [[UIView alloc] init];
        [self.containerView addSubview:view];
        self.leftView = view;
    }

    if (self.titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        self.titleLabel = label;
    }
    if (self.recommenTitleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        self.recommenTitleLabel = label;
    }
    if (self.subTitleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        self.subTitleLabel = label;
    }
    if (self.typeImageView == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.containerView addSubview:img];
        self.typeImageView = img;
    }
    [self createConstraints];
}

- (void)createConstraints {
    if (self.containerView) {
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(kContainerRight);
        }];
    }
    if (self.leftView) {
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.containerView);
            make.width.mas_equalTo(kLeftViewWidth);
        }];
    }
    if (self.typeImageView) {
        [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.containerView).offset(kTypeImageViewRight);
            make.top.equalTo(self.containerView).offset(kTypeImageViewTop);
            make.height.mas_equalTo(kTypeImageViewHeight);
            make.width.mas_equalTo(kTypeImageViewWidth);
        }];
    }
    if (self.titleLabel) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(kTitleLabelLeft);
            make.top.equalTo(self.containerView).offset(kTitleLabelTop);
            make.right.lessThanOrEqualTo(self.typeImageView.mas_left).offset(kTitleLabelRight);
        }];
    }
    if (self.recommenTitleLabel) {
        [self.recommenTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(kRecommenTitleLabelTop);
            make.right.lessThanOrEqualTo(self.typeImageView.mas_left).offset(kRecommenTitleLabelRight);
        }];
    }
    if (self.subTitleLabel) {
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.bottom.equalTo(self.containerView).offset(kSubTitleLabelBottom);
            make.right.lessThanOrEqualTo(self.typeImageView.mas_left).offset(kTitleLabelRight);
        }];
    }
}

- (void)styleInit {
    self.backgroundColor = [UIColor clearColor];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.leftView.backgroundColor = YD_GRAY(204);
    self.titleLabel.font = YDF_SYS(18);
    self.titleLabel.textColor = YD_RGB(  51,  51,  51);
    self.recommenTitleLabel.font = YDF_SYS(13.f);
    self.recommenTitleLabel.textColor = YD_RGBA(102, 102, 102, 1);
    self.recommenTitleLabel.numberOfLines = 1;
    self.subTitleLabel.font = YDF_SYS(13);
    self.subTitleLabel.textColor = YDC_TEXT;
    self.typeImageView.contentMode = UIViewContentModeScaleToFill;
}
@end
