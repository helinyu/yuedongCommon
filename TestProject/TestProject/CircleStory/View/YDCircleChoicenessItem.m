//
//  YDCircleChoicenessItem.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCircleChoicenessItem.h"
#import "YDCircleThemeModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface YDCircleChoicenessItem ()

@property (nonatomic, strong) UIControl *container;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YDCircleChoicenessItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
        [self createConstraints];
        [self styleInit];
    }
    return self;
}
- (void)setThemeInfo:(YDCircleThemeModel *)theme {
    self.titleLabel.text = MSLocalizedString(theme.themeTitle, nil);
    [self.icon sd_setImageWithURL:[NSURL yd_URLWithString:theme.themeIconUrl] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];
}
- (void)comInit {
    if (self.container == nil) {
        self.container = [[UIControl alloc] init];
        [self.contentView addSubview:self.container];
    }
    if (self.icon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.container addSubview:img];
        self.icon = img;
    }
    if (self.titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.container addSubview:label];
        self.titleLabel = label;
    }
}
- (void)createConstraints {
    if (self.container) {
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    if (self.icon) {
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.container);
            make.top.equalTo(self.container).offset(12.f);
            make.width.height.mas_equalTo(33.f);
        }];
    }
    if (self.titleLabel) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.container);
            make.top.equalTo(self.icon.mas_bottom).offset(6.f);
            make.left.equalTo(self.container).offset(3.f);
        }];
    }
}
- (void)styleInit {
    self.contentView.backgroundColor = YD_WHITE(1);
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = YDF_SYS(14.f);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = YDC_TITLE;
    
    [self.container addTarget: self action: @selector(actionToNormal) forControlEvents: UIControlEventTouchCancel];
    [self.container addTarget: self action: @selector(actionToWeb) forControlEvents: UIControlEventTouchUpInside];
    [self.container addTarget: self action: @selector(actionToNormal) forControlEvents: UIControlEventTouchDragOutside];
    [self.container addTarget: self action: @selector(actionToNormal) forControlEvents: UIControlEventTouchUpOutside];
    [self.container addTarget: self action: @selector(actionToNormal) forControlEvents:UIControlEventTouchDragExit];
    [self.container addTarget: self action: @selector(actionToHighLight) forControlEvents: UIControlEventTouchDown];
}

- (void)actionToHighLight {
    self.container.alpha = 0.5;
}
- (void)actionToWeb {
    [self actionToNormal];
    !_action ?:_action();
}
- (void)actionToNormal {
    self.container.alpha = 1.0;
}
@end
