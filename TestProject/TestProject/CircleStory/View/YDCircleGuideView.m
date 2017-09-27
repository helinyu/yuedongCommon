//
//  YDCircleGuideView.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleGuideView.h"

static const CGFloat kTextImageViewTop = -50;
static const CGFloat kButtonBottom = -150;


@interface YDCircleGuideView ()

@property (nonatomic,   weak) UIImageView *textImageView;

@end

@implementation YDCircleGuideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    if (self.textImageView == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        self.textImageView = img;
    }
    if (self.button == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        self.button = btn;
    }
    
    self.textImageView.image = [UIImage imageNamed:@"icon_origin_circle_guide"];
    [self.button setImage:[UIImage imageNamed:@"icon_origin_circle_lookbtn"] forState:UIControlStateNormal];
    [self.textImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(kTextImageViewTop);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(kButtonBottom);
    }];
    
}




@end
