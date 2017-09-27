//
//  YDCircleChoicenessCell.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleChoicenessCell.h"
#import "YDSingleCircleView.h"
#import "YDCircleThemeModel.h"
#import "UIImageView+WebCache.h"
#import "YDImageControl.h"

static const CGFloat kSportCyclopediaTop = 12;
static const CGFloat kSportCyclopediaHeight = 54;
@implementation YDCircleChoicenessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        [self styleInit];
    }
    return self;
}

- (void)setThemeInfos:(NSArray<YDCircleThemeModel *> *)themeInfos {
    _themeInfos = themeInfos;
    NSInteger sort = 0;
    for (YDCircleThemeModel *obj in themeInfos) {
        switch (sort) {
//            case 4:
//            {
//                self.live.titleLabel.text = MSLocalizedString(obj.themeTitle, nil);
//                [self.live.imageControl.icon sd_setImageWithURL:[NSURL yd_URLWithString:obj.themeIconUrl] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];
//            }
//                break;
            case 0:
            {
                self.sportCyclopedia.titleLabel.text = MSLocalizedString(obj.themeTitle, nil);
                [self.sportCyclopedia.imageControl.icon sd_setImageWithURL:[NSURL yd_URLWithString:obj.themeIconUrl] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];
            }
                break;
            case 1:
            {
                self.topicDiscuss.titleLabel.text = MSLocalizedString(obj.themeTitle, nil);
                [self.topicDiscuss.imageControl.icon sd_setImageWithURL:[NSURL yd_URLWithString:obj.themeIconUrl] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];
            }
                break;
            case 2:
            {
                self.fitnessVideo.titleLabel.text = MSLocalizedString(obj.themeTitle, nil);
                [self.fitnessVideo.imageControl.icon sd_setImageWithURL:[NSURL yd_URLWithString:obj.themeIconUrl] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];

            }
                break;
            default:
                break;
        }
        sort ++;
    }
    [self setNeedsUpdateConstraints];
}

- (void)addSubviews {
    if (self.live == nil) {
        YDSingleCircleView *view = [[YDSingleCircleView alloc] initWithType:YDCellSingleViewTypeChoiceness frame:CGRectZero];
        [self.contentView addSubview:view];
        self.live = view;
    }
    if (self.sportCyclopedia == nil) {
        YDSingleCircleView *view = [[YDSingleCircleView alloc] initWithType:YDCellSingleViewTypeChoiceness frame:CGRectZero];
        [self.contentView addSubview:view];
        self.sportCyclopedia = view;
    }
    if (self.topicDiscuss == nil) {
        YDSingleCircleView *view = [[YDSingleCircleView alloc] initWithType:YDCellSingleViewTypeChoiceness frame:CGRectZero];
        [self.contentView addSubview:view];
        self.topicDiscuss = view;
    }
    if (self.fitnessVideo == nil) {
        YDSingleCircleView *view = [[YDSingleCircleView alloc] initWithType:YDCellSingleViewTypeChoiceness frame:CGRectZero];
        [self.contentView addSubview:view];
        self.fitnessVideo = view;
    }
    [self createConstraints];
}
- (void)createConstraints {
    CGFloat width = SCREEN_WIDTH_V0 / 3;
//    if (self.live) {
//        [self.live mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView);
//            make.top.equalTo(self.contentView).offset(kSportCyclopediaTop);
//            make.width.mas_equalTo(width);
//            make.height.mas_equalTo(kSportCyclopediaHeight);
//        }];
//    }
    if (self.sportCyclopedia) {
        [self.sportCyclopedia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(kSportCyclopediaTop);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(kSportCyclopediaHeight);
        }];
    }
    if (self.topicDiscuss) {
        [self.topicDiscuss mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sportCyclopedia.mas_right);
            make.top.equalTo(self.sportCyclopedia);
            make.width.height.equalTo(self.sportCyclopedia);
        }];
    }
    if (self.fitnessVideo) {
        [self.fitnessVideo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topicDiscuss.mas_right);
            make.top.equalTo(self.sportCyclopedia);
            make.width.height.equalTo(self.sportCyclopedia);
        }];
    }
}
- (void)styleInit {
    
}

- (void)updateConstraints {
    
    CGFloat height = self.themeInfos.count ? kSportCyclopediaHeight : 0;
    CGFloat top = self.themeInfos.count ? kSportCyclopediaTop : 0;
    CGFloat width = 0;
    if (self.themeInfos.count != 0) {
        width = SCREEN_WIDTH_V0 / self.themeInfos.count;
    } else {
        width = SCREEN_WIDTH_V0;
    }
    [self.sportCyclopedia mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(top);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    //    CGFloat lineTop = self.circles.count ? kLineViewTop : 0;
    //    CGFloat lineHeight = self.circles.count ? kLineViewHeight : 0;
    //    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.firstCircle.mas_bottom).offset(lineTop);
    //        make.left.right.equalTo(self.contentView);
    //        make.height.mas_equalTo(lineHeight);
    //    }];
    [super updateConstraints];
}
@end
