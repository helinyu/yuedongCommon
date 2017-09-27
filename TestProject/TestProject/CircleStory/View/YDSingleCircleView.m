//
//  YDSingleCircleView.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDSingleCircleView.h"
#import "YDImageControl.h"

static const CGFloat kIconWH = 42;
static const CGFloat kTitleLabelLeft = 3;

@implementation YDSingleCircleView

- (instancetype)initWithType:(YDCellSingleViewType)type frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (self.imageControl == nil) {
            YDImageControl *imgControl = [[YDImageControl alloc] init];
            [self addSubview:imgControl];
            self.imageControl = imgControl;
        }
        if (self.titleLabel == nil) {
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            self.titleLabel = label;
        }
//        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionToWeb)];
//        [self addGestureRecognizer:tap];
        
        [self.imageControl addTarget: self action: @selector(actionToNormal) forControlEvents: UIControlEventTouchCancel];
        [self.imageControl addTarget: self action: @selector(actionToWeb) forControlEvents: UIControlEventTouchUpInside];
        [self.imageControl addTarget: self action: @selector(actionToNormal) forControlEvents: UIControlEventTouchDragOutside];
        [self.imageControl addTarget: self action: @selector(actionToNormal) forControlEvents: UIControlEventTouchUpOutside];
        [self.imageControl addTarget: self action: @selector(actionToNormal) forControlEvents:UIControlEventTouchDragExit];
        [self.imageControl addTarget: self action: @selector(actionToHighLight) forControlEvents: UIControlEventTouchDown];
        self.titleLabel.textColor = RGBA(51, 51, 51, 1);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat iconWh = 0;
        switch (type) {
            case YDCellSingleViewTypeCircle:
            {
                self.imageControl.icon.layer.cornerRadius = kIconWH / 2;
                self.imageControl.icon.clipsToBounds = YES;
                self.titleLabel.font = YDF_SYS(13);
                iconWh = kIconWH;
            }
                break;
            case YDCellSingleViewTypeChoiceness:
            {   
                self.titleLabel.font = YDF_SYS(14);
                iconWh = 33;
            }
                break;
            default:
                break;
        }
        [self.imageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            make.height.width.mas_equalTo(iconWh);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.imageControl.mas_bottom).offset(kTitleLabelTop);
//            make.centerX.equalTo(self.icon);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(kTitleLabelLeft);
            make.right.equalTo(self).offset(-kTitleLabelLeft);
        }];
    }
    return self;
}

- (void)actionToHighLight {
    self.imageControl.icon.alpha = 0.5;
}
- (void)actionToWeb {
    [self actionToNormal];
    !_action ?:_action();
}
- (void)actionToNormal {
    self.imageControl.icon.alpha = 1.0;
}
@end
