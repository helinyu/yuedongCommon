//
//  YDCirThemeArticleOrTopicCell.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleSubThemeArticleCell.h"
#import <UIImageView+WebCache.h>
#import "YDCircleThemeArticleModel.h"
#import "YDOriginCircleModel.h"

static const CGFloat kLeftImageViewLeft = 12;
static const CGFloat kLeftImageViewTop = 8;
static const CGFloat kLeftImageViewBottom = -8;
static const CGFloat kTitleLabelLeft = 12;
static const CGFloat kTitleLabelTop = 5;
static const CGFloat kTypeIconBottom = -5;
static const CGFloat kTypeIconLeft = 12;
static const CGFloat kTypeIconWH = 16;
static const CGFloat kTypeLabelLeft = 7;
static const CGFloat kDiscussLabelRight = -12;
static const CGFloat kDiscussIconRight = -7;
static const CGFloat kLikeCountLabelRight = -21;
static const CGFloat kLikeButtonRight = -6;

@interface YDCircleSubThemeArticleCell ()

@property (nonatomic,   weak) UIImageView *leftImageView;
@property (nonatomic,   weak) UILabel *titleLabel;
@property (nonatomic,   weak) UIImageView *typeIcon;
@property (nonatomic,   weak) UILabel *typeLabel;
@property (nonatomic,   weak) UIButton *likeButton;
@property (nonatomic,   weak) UILabel *likeCountLabel;
@property (nonatomic,   weak) UIImageView *discussIcon;
@property (nonatomic,   weak) UILabel *discussCountLabel;

@end

@implementation YDCircleSubThemeArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        [self styleInit];
    }
    return self;
}

- (void)setModel:(YDCircleThemeArticleModel *)model {
    _model = model;
    [self.leftImageView sd_setImageWithURL:[NSURL yd_URLWithString:model.articleIconUrl] placeholderImage:[UIImage imageNamed:@"img_origin_circle_topic_placeholder_small.jpg"]];
    self.titleLabel.text = MSLocalizedString(model.articleTitle, nil);
    [self.typeIcon sd_setImageWithURL:[NSURL yd_URLWithString:model.circle.icon]];
    self.typeLabel.text = MSLocalizedString(model.circle.name, nil);
    NSString *likeCntStr = [NSString stringWithFormat:@"%@",model.likeCnt];
    self.likeCountLabel.text = MSLocalizedString(likeCntStr, nil);
    NSString *discussCntStr = [NSString stringWithFormat:@"%@",model.articleDiscussCnt];
    self.discussCountLabel.text = MSLocalizedString(discussCntStr, nil);
}

- (void)addSubviews {
    if (self.leftImageView == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.leftImageView = img;
    }
    if (self.titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.titleLabel = label;
    }
    if (self.typeIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.typeIcon = img;
    }
    if (self.typeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.typeLabel = label;
    }
    if (self.likeButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        self.likeButton = btn;
    }
    if (self.likeCountLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.likeCountLabel = label;
    }
    if (self.discussIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.discussIcon = img;
    }
    if (self.discussCountLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.discussCountLabel = label;
    }
    
    [self createConstraints];
}

- (void)createConstraints {
    if (self.leftImageView) {
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kLeftImageViewLeft);
            make.top.equalTo(self.contentView).offset(kLeftImageViewTop);
            make.bottom.equalTo(self.contentView).offset(kLeftImageViewBottom);
            make.width.equalTo(self.leftImageView.mas_height).multipliedBy(105.f/85);
        }];
    }
    if (self.titleLabel) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImageView.mas_right).offset(kTitleLabelLeft);
            make.right.equalTo(self.contentView).offset(-kTitleLabelLeft);
            make.top.equalTo(self.leftImageView).offset(kTitleLabelTop);
        }];
    }
    if (self.typeIcon) {
        [self.typeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImageView.mas_right).offset(kTypeIconLeft);
            make.bottom.equalTo(self.leftImageView).offset(kTypeIconBottom);
            make.width.height.mas_equalTo(kTypeIconWH);
        }];
    }
    if (self.typeLabel) {
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeIcon.mas_right).offset(kTypeLabelLeft);
            make.centerY.equalTo(self.typeIcon);
        }];
    }
    if (self.discussCountLabel) {
        [self.discussCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(kDiscussLabelRight);
            make.centerY.equalTo(self.typeIcon);
        }];
    }
    if (self.discussIcon) {
        [self.discussIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.discussCountLabel.mas_left).offset(kDiscussIconRight);
            make.centerY.equalTo(self.typeIcon);
        }];
    }
    if (self.likeCountLabel) {
        [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.discussIcon.mas_left).offset(kLikeCountLabelRight);
            make.centerY.equalTo(self.typeIcon);
        }];
    }
    if (self.likeButton) {
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.likeCountLabel.mas_left).offset(kLikeButtonRight);
            make.centerY.equalTo(self.typeIcon);
        }];
    }
}

- (void)styleInit {
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.leftImageView.clipsToBounds = YES;
    self.titleLabel.font = YDF_SYS(17);
    self.titleLabel.textColor = YD_RGB(  60,  60,  60);
    self.titleLabel.numberOfLines = 2;
    self.typeIcon.layer.cornerRadius = kTypeIconWH / 2;
    self.typeIcon.clipsToBounds = YES;
    self.typeLabel.textColor = YD_GRAY(204);
    self.typeLabel.font = YDF_SYS(12);
    self.likeButton.userInteractionEnabled = NO;
    [self.likeButton setImage:[UIImage imageNamed:@"icon_origin_circle_theme_like"] forState:UIControlStateNormal];
    self.discussIcon.image = [UIImage imageNamed:@"icon_origin_circle_theme_comment"];
    self.likeCountLabel.textColor = YD_GRAY(204);
    self.likeCountLabel.font = YDF_SYS(12);
    self.likeCountLabel.text = MSLocalizedString(@"0", nil);
    self.discussCountLabel.textColor = YD_GRAY(204);
    self.discussCountLabel.font = YDF_SYS(12);
    self.discussCountLabel.text = MSLocalizedString(@"0", nil);
}
@end
