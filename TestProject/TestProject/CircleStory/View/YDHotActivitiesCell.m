//
//  YDHotActivitiesCell.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDHotActivitiesCell.h"
#import "YDSingleHotActivityView.h"
#import "YDActivityModel.h"

static const CGFloat kPadding = 11;
static const CGFloat kFirstActivityLeft = 12;
static const CGFloat kFirstActivityTop = 10;
static const CGFloat kThirdActivityTop = 8;

@interface YDHotActivitiesCell ()


@end
@implementation YDHotActivitiesCell
- (void)setActivities:(NSArray<YDActivityModel *> *)activities {
    _activities = activities;
    NSInteger sortOfImages = 0;
    for (YDActivityModel *obj in activities) {
        switch (sortOfImages) {
            case 0:
                self.firstActivity.model = obj;
                break;
            case 1:
                self.secondActivity.model = obj;
                break;
            case 2:
                self.thirdActivity.model = obj;
                break;
            case 3:
                self.fourthActivity.model = obj;
                break;
            default:
                break;
        }
        sortOfImages ++;
    }
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    if (self.firstActivity == nil) {
        YDSingleHotActivityView *view = [[YDSingleHotActivityView alloc] init];
        [self.contentView addSubview:view];
        self.firstActivity = view;
    }
    if (self.secondActivity == nil) {
        YDSingleHotActivityView *view = [[YDSingleHotActivityView alloc] init];
        [self.contentView addSubview:view];
        self.secondActivity = view;
    }
    if (self.thirdActivity == nil) {
        YDSingleHotActivityView *view = [[YDSingleHotActivityView alloc] init];
        [self.contentView addSubview:view];
        self.thirdActivity = view;
    }
    if (self.fourthActivity == nil) {
        YDSingleHotActivityView *view = [[YDSingleHotActivityView alloc] init];
        [self.contentView addSubview:view];
        self.fourthActivity = view;
    }
    
    CGFloat kWidth = (SCREEN_WIDTH_V0 - 2 * kFirstActivityLeft - kPadding) / 2;
    CGFloat kHeight = kWidth * 88.f / 170;
    [self.firstActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kFirstActivityLeft);
        make.top.equalTo(self.contentView).offset(kFirstActivityTop);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(kHeight);
    }];
    [self.secondActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstActivity.mas_right).offset(kPadding);
        make.top.equalTo(self.contentView).offset(kFirstActivityTop);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(kHeight);
    }];
    [self.thirdActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kFirstActivityLeft);
        make.top.equalTo(self.firstActivity.mas_bottom).offset(kThirdActivityTop);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(kHeight);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(kThirdActivityBottom).priorityHigh();
    }];
    [self.fourthActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdActivity.mas_right).offset(kPadding);
        make.top.equalTo(self.secondActivity.mas_bottom).offset(kThirdActivityTop);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(kHeight);
    }];

}

@end
