//
//  YDTopicRecommendItem.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDTopicRecommendItem.h"
#import "YDTopicRecommendInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YDAccountMgr.h"
#import "YDDataSolver.h"

@interface YDTopicRecommendItem ()

@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *addFollowBtn;
@property (nonatomic, strong) UIButton *cancleFollowBtn;

@end

@implementation YDTopicRecommendItem
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
- (void)setModel:(YDTopicRecommendInfo *)model {
    _model = model;
    NSString *avatarString = [NSString stringWithFormat:[YDURL HEAD_URL],model.userId,HEAD_IMG_DEFAULT_SIZE];
    [self.userIcon sd_setImageWithURL:[NSURL yd_URLWithString:avatarString] placeholderImage:[UIImage imageNamed:@"img_head_default"]];
    self.nickLabel.text = model.nick;
    self.descLabel.text = model.talentTitle;
    if (model.followStatus.integerValue == 0) { //未关注
        self.addFollowBtn.hidden=NO;
        self.cancleFollowBtn.hidden=YES;
    } else {
        self.addFollowBtn.hidden=YES;
        self.cancleFollowBtn.hidden=NO;
    }
}
- (void)comInit {
    if (self.userIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.userIcon = img;
    }
    if (self.nickLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.nickLabel = label;
    }
    if (self.descLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.descLabel = label;
    }
    if (self.addFollowBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        self.addFollowBtn = btn;
    }
    if (self.cancleFollowBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        self.cancleFollowBtn = btn;
    }
}
- (void)createConstraints {
    if (self.userIcon) {
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(DEVICE_HEIGHT_OF(19.f));
            make.width.height.mas_equalTo(DEVICE_WIDTH_OF(64.f));
        }];
    }
    if (self.nickLabel) {
        [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userIcon.mas_bottom).offset(DEVICE_HEIGHT_OF(6.f));
            make.centerX.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(25.f);
        }];
    }
    if (self.descLabel) {
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickLabel.mas_bottom).offset(DEVICE_HEIGHT_OF(4.f));
            make.centerX.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(DEVICE_WIDTH_OF(9.f));
        }];
    }
    if (self.addFollowBtn) {
        [self.addFollowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.descLabel.mas_bottom).offset(DEVICE_HEIGHT_OF(10.f));
            make.centerX.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(DEVICE_WIDTH_OF(10.f));
            make.height.mas_equalTo(32.f);
        }];
    }
    if (self.cancleFollowBtn) {
        [self.cancleFollowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.addFollowBtn);
        }];
    }
    
}
- (void)styleInit {
    self.backgroundColor = YDC_BG;
    self.layer.cornerRadius = 3.f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = YDC_SP.CGColor;
    self.layer.borderWidth = 0.5f;
    self.userIcon.contentMode = UIViewContentModeScaleAspectFill;
    self.userIcon.layer.cornerRadius = DEVICE_WIDTH_OF(64.f)/2;
    self.userIcon.layer.masksToBounds = YES;
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        self.nickLabel.font = YDF_SYS_FIT(15.f);
    } else {
        self.nickLabel.font = YDF_CUS_FIT(YDFontPFangMedium, 15.f);
    }
    self.nickLabel.textColor = YDC_TITLE;
    self.nickLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.font = YDF_SYS_FIT(11.f);
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.textColor = YD_RGBA(102, 102, 102, 1);
    [self.addFollowBtn setTitle:MSLocalizedString(@"关注", nil) forState:UIControlStateNormal];
    [self.cancleFollowBtn setTitle:MSLocalizedString(@"已关注", nil) forState:UIControlStateNormal];
    [self.addFollowBtn setTitleColor:YDC_G forState:UIControlStateNormal];
    [self.cancleFollowBtn setTitleColor:YDC_TEXT forState:UIControlStateNormal];
    self.addFollowBtn.titleLabel.font = YDF_SYS(15.f);
    self.cancleFollowBtn.titleLabel.font = YDF_SYS(15.f);
    self.addFollowBtn.layer.borderWidth = 1.f;
    self.addFollowBtn.layer.cornerRadius = 3.f;
    self.addFollowBtn.layer.masksToBounds = YES;
    self.addFollowBtn.layer.borderColor = YDC_G.CGColor;
    self.cancleFollowBtn.layer.borderWidth = 1.f;
    self.cancleFollowBtn.layer.cornerRadius = 3.f;
    self.cancleFollowBtn.layer.masksToBounds = YES;
    self.cancleFollowBtn.layer.borderColor = YDC_SP.CGColor;
    [self.addFollowBtn setImage:[UIImage imageNamed:@"icon_circle_add_follow"] forState:UIControlStateNormal];
    [self.addFollowBtn addTarget:self action:@selector(event_addFollow) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleFollowBtn addTarget:self action:@selector(event_cancleFollow) forControlEvents:UIControlEventTouchUpInside];
}
- (void)event_addFollow {
    [self net_addFriend:YES];
}
- (void)event_cancleFollow {
    [self net_addFriend:NO];
}
- (void)net_addFriend:(BOOL)toFollow {
    __weak typeof(self) wSelf = self;
    NSString *operType = @"add_follow";
    if (!toFollow) {
        operType = @"cancel_follow";
    }
    [[YDAccountMgr shared] net_checkFollowWithParam:[YDDataSolver userFollowWithUserID: [YDAppInstance userId] andGotUserID: nil andOperType: operType andFollowUserID: self.model.userId andBeginCnt: nil andEndCnt: nil] then:^(id response, MSError *error) {
        if (!error) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                NSNumber *status = response[@"status"];
                if(status.integerValue == 1 || status.integerValue == 3)
                {
                    [[YDStatisticsMgr sharedMgr] eventCircleRecommendAddFollow];
                    wSelf.model.followStatus = @1;
                    wSelf.addFollowBtn.hidden=YES;
                    wSelf.cancleFollowBtn.hidden=NO;
                }else
                {
                    wSelf.model.followStatus = @1;
                    wSelf.cancleFollowBtn.hidden=YES;
                    wSelf.addFollowBtn.hidden=NO;
                }
            }
        }
        
    }];
}
@end
