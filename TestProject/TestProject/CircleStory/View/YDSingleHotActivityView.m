//
//  YDSingleHotActivityView.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDSingleHotActivityView.h"
#import "YDActivityModel.h"
#import "UIImageView+WebCache.h"

static const CGFloat kTitleLabelTop = 16;
static const CGFloat kTitleLabelLeft = 12;
static const CGFloat kSubTitleLabelTop = 8;


@interface YDSingleHotActivityView ()

@end
@implementation YDSingleHotActivityView

- (void)setModel:(YDActivityModel *)model {
    _model = model;
    self.titleLabel.text = MSLocalizedString(model.title, nil);
    self.subTitleLabel.text = MSLocalizedString(model.desc, nil);
    [self.backImageView sd_setImageWithURL:[NSURL yd_URLWithString:model.iconNew] placeholderImage:[UIImage imageNamed:@"img_origin_circle_topic_placeholder_small.jpg"]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addsubviews];
        [self styleInit];
    }
    return self;
}

- (void)addsubviews {
    if (self.backImageView == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        self.backImageView = img;
    }
//    if (self.shadowView == nil) {
//        YDGradientBarView *view = [[YDGradientBarView alloc] initWithStartColor:RGBA(0, 0, 0, 0.65) endColor:RGBA(255, 255, 255, 0) cornerRadius:0 startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1) frame:CGRectZero];
//        [self addSubview:view];
//        self.shadowView = view;
//    }
    if (self.titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        self.titleLabel = label;
    }
    if (self.subTitleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        self.subTitleLabel = label;
    }

    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kTitleLabelTop);
        make.left.equalTo(self).offset(kTitleLabelLeft);
    }];
    CGFloat kSubTitleLabelWidth = DEVICE_WIDTH_OF(88.f);
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kSubTitleLabelTop);
        make.left.equalTo(self.titleLabel);
        make.width.mas_equalTo(kSubTitleLabelWidth);
    }];
//    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    self.backImageView.clipsToBounds = YES;
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    
}
- (void)styleInit {
    self.titleLabel.textColor = RGBA(255, 255, 255, 1);
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.subTitleLabel.textColor = RGBA(255, 255, 255, 1);
    self.subTitleLabel.font = [UIFont systemFontOfSize:12];
    self.subTitleLabel.numberOfLines = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionToWeb)];
    [self addGestureRecognizer:tap];
}

/**
 *  点击跳转活动详情
 */
- (void)actionToWeb {
    !_action ?:_action();
}

@end
