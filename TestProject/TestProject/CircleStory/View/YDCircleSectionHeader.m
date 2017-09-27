//
//  YDCircleSectionHeader.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleSectionHeader.h"

static const CGFloat kLeftGreenViewWidth = 3;
static const CGFloat kLeftGreenViewHeight = 20;
static const CGFloat kTypeLabelLeft = 12;
static const CGFloat kCheckBtnRight = 6;
static const CGFloat kCheckIconRight = 10;

@interface YDCircleSectionHeader ()
@property (nonatomic,   weak) UIView *leftGreenView;

@end
@implementation YDCircleSectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (self.leftGreenView == nil) {
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            self.leftGreenView = view;
        }
        if (self.typeLabel == nil) {
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            self.typeLabel = label;
        }
        if (self.checkMoreBtn == nil) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            self.checkMoreBtn = btn;
        }
        if (self.checkIcon == nil) {
            UIImageView *img = [[UIImageView alloc] init];
            [self addSubview:img];
            self.checkIcon = img;
        }
        if (self.bottomView == nil) {
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            self.bottomView = view;
        }
        
        self.backgroundColor = [UIColor whiteColor];
        self.leftGreenView.backgroundColor = YDC_G;
        self.typeLabel.textColor = RGBA(34, 34, 34, 1);
        self.typeLabel.font = [UIFont systemFontOfSize:15];
        
        self.checkMoreBtn.titleLabel.font = YDF_SYS(12.f);
        [self.checkMoreBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
        NSString *string = MSLocalizedString(@"查看全部", nil);
        [self.checkMoreBtn setTitle:string forState:UIControlStateNormal];
        self.checkIcon.image = [UIImage imageNamed:@"icon_origin_circle_all"];
        
        self.bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        if (self.leftGreenView) {
            [self.leftGreenView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(12.f);
                make.left.equalTo(self);
                make.width.mas_equalTo(kLeftGreenViewWidth);
                make.height.mas_equalTo(kLeftGreenViewHeight);
            }];
        }
        if (self.typeLabel) {
            [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(kTypeLabelLeft);
                make.centerY.equalTo(self.leftGreenView);
            }];
        }
        [self.checkIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-kCheckIconRight);
            make.centerY.equalTo(self.typeLabel);
        }];
        [self.checkMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.typeLabel);
            make.right.equalTo(self.checkIcon.mas_left).offset(-kCheckBtnRight);
        }];
        
        [self.checkMoreBtn addTarget:self action:@selector(checkMore) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)checkMore {
    !_action ?:_action();
}
@end
