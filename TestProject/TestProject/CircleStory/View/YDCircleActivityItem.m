//
//  YDCircleActivityItem.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCircleActivityItem.h"
#import "YDActivityModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

static const CGFloat kTitleLabelTop = 16;
static const CGFloat kTitleLabelLeft = 12;
static const CGFloat kSubTitleLabelTop = 8;

@interface YDCircleActivityItem ()

@property (nonatomic,   weak) UIControl *container;
@property (nonatomic,   weak) UILabel *titleLabel;
@property (nonatomic,   weak) UILabel *subTitleLabel;
@property (nonatomic,   weak) UIImageView *backImageView;

@end

@implementation YDCircleActivityItem


- (void)setModel:(YDActivityModel *)model {
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
    
    if (self.container == nil) {
        UIControl *control = [[UIControl alloc] init];
        [self.contentView addSubview:control];
        self.container = control;
    }
    if (self.backImageView == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.container addSubview:img];
        self.backImageView = img;
    }
    if (self.titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.container addSubview:label];
        self.titleLabel = label;
    }
    if (self.subTitleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.container addSubview:label];
        self.subTitleLabel = label;
    }
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.container);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.container).offset(kTitleLabelTop);
        make.left.equalTo(self.container).offset(kTitleLabelLeft);
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
    self.contentView.backgroundColor = YD_WHITE(1);
    self.titleLabel.textColor = RGBA(255, 255, 255, 1);
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.subTitleLabel.textColor = RGBA(255, 255, 255, 1);
    self.subTitleLabel.font = [UIFont systemFontOfSize:12];
    self.subTitleLabel.numberOfLines = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionToWeb)];
    [self addGestureRecognizer:tap];
}
- (void)actionToWeb {
    !_action ?:_action();
}

@end
