//
//  YDCircleTopicItem.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCircleTopicItem.h"
#import "YDInsetLabel.h"
#import "YDHotTopicModel.h"
#import "YDUserModel.h"
#import "YDOriginCircleModel.h"
#import "UIImageView+WebCache.h"

//const CGFloat SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
//const CGFloat SCREEN_HEIGHT = [UIScreen mainScreen].bounds.size.height;

static const CGFloat kUserIconTop = 14;
static const CGFloat kUserIconLeft = 12;
static const CGFloat kUserIconWH = 40;
static const CGFloat knickNameLabelTop = 15;
static const CGFloat knickNameLabelLeft = 10;
static const CGFloat kLevelLabelTop = 3.5;
static const CGFloat kSexIconLeft = 9;
static const CGFloat kSexIconWH = 16;
static const CGFloat kFollowBtnRight = -12;
static const CGFloat kFollowBtnTop = 24;
static const CGFloat kFollowBtnW = 50;
static const CGFloat kFollowBtnH = 28;

static const CGFloat kFirstImgLeft = 12;
//static const CGFloat kFirstImgH = kFirstImgW * 196 / 308;
static const CGFloat kPadding = 8.f;

static const CGFloat kTitleLabelLeft = 12;
//static const CGFloat kTitleLabelTop = 16;
static const CGFloat kDetailLabelLeft = 12;
//static const CGFloat kDetailLabelTop = 8;
//static const CGFloat kDetailLabelHeight = 44;
//static const CGFloat kDetailLabelRight = -12;
//static const CGFloat kAreaLabelTop = 10;
static const CGFloat kAreaLabelLeft = 13;
static const CGFloat kTypeIconLeft = 12;
static const CGFloat kTypeIconTop = 14;
static const CGFloat kTypeIconWH = 20;
static const CGFloat kTypeLabelLeft = 8;

static const CGFloat kDiscussCountLabelRight = -14;
static const CGFloat kDiscussIconRight = -6;
static const CGFloat kLikeCountLabelRight = -22;
static const CGFloat kLikeButtonRight = -7;

static const CGFloat kVideoTimeLabelBottom = -8;
static const CGFloat kVideoTimeLabelRight = -12;
static const CGFloat kBottomViewTop = 14;

static const CGFloat kStatusViewRight = -7.f;
static const CGFloat kStatusViewTop = 7.f;
static const CGFloat kStatusViewHeight = 20.f;
static const CGFloat kStatusViewWidth = 54.f;
static const CGFloat kStatusLabelLeft = 4.f;
static const CGFloat kLivingCirclePointLeft = 11.f;
static const CGFloat kLivingCirclePointWH = 6.f;

@interface YDCircleTopicItem ()

@property (nonatomic,   weak) UIImageView *userIcon;
@property (nonatomic,   weak) UILabel *nickNameLabel;
@property (nonatomic,   weak) UILabel *levelLabel;
@property (nonatomic,   weak) UIImageView *sexIcon;
@property (nonatomic,   weak) UIImageView *talentIcon;
@property (nonatomic,   weak) UIView *honorContainer;
@property (nonatomic,   weak) UIImageView *honorIcon;
@property (nonatomic,   weak) UILabel *honorTitleLabel;

@property (nonatomic,   weak) UIImageView *firstImg;
@property (nonatomic,   weak) UIImageView *secondImg;
@property (nonatomic,   weak) UIImageView *thirdImg;

@property (nonatomic,   weak) YDInsetLabel *titleLabel;
@property (nonatomic,   weak) YDInsetLabel *detailLabel;
@property (nonatomic,   weak) UIImageView *typeIcon;
@property (nonatomic,   weak) UILabel *typeLabel;

@property (nonatomic,   weak) UIButton *discussButton;
//@property (nonatomic,   weak) UIImageView *discussIcon;
//@property (nonatomic,   weak) UILabel *discussCountLabel;

@property (nonatomic,   weak) UIView *bottomLineView;
@property (nonatomic,   weak) UIImageView *playVideoImg;
@property (nonatomic,   weak) UILabel *videoTimeLabel;
@property (nonatomic,   weak) YDInsetLabel *areaLabel;

//live
@property (nonatomic,   weak) UIImageView *watchIcon;
@property (nonatomic,   weak) UILabel *watchCountLabel;
@property (nonatomic,   weak) UIView *statusView;
@property (nonatomic,   weak) UIView *livingCirclePoint;
@property (nonatomic,   weak) UILabel *statusLabel;



@end

@implementation YDCircleTopicItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self styleInit];
    }
    return self;
}
- (void)setModel:(YDHotTopicModel *)model {
    
    //    if (_model != nil && _model.topicId != model.topicId) {
    self.userIcon.image = nil;
    self.sexIcon.image = nil;
    [self.secondImg removeFromSuperview];
    [self.thirdImg removeFromSuperview];
    self.firstImg.image = nil;
    self.secondImg = nil;
    self.thirdImg = nil;
    self.typeIcon.image = nil;
    //    }
    //    if (_model.topicId != model.topicId) {
    _model = model;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.user.avatar] placeholderImage:[UIImage imageNamed:@"img_head_default"]];
    self.nickNameLabel.text = MSLocalizedString(model.user.name, nil);
    if (model.user.isMemberShip) {
        self.nickNameLabel.textColor = [UIColor colorWithRed:247./255.0 green:78/255.0f blue:84.0/255.f alpha:1.0];
    }else{
        self.nickNameLabel.textColor = RGBA(102, 102, 102, 1);
    }
    NSString *lv = [NSString stringWithFormat:@"Lv %ld",(long)model.user.lv];
    self.levelLabel.text = MSLocalizedString(lv, nil);
    if (model.user.gender) {
        self.sexIcon.image = [UIImage imageNamed:@"icon_circle_female"];
    } else {
        self.sexIcon.image = [UIImage imageNamed:@"icon_circle_male"];
    }
    if (model.user.honorTitle.length) {
        self.honorTitleLabel.text = model.user.honorTitle;
        self.honorContainer.hidden = NO;
    } else {
        self.honorTitleLabel.text = nil;
        self.honorContainer.hidden = YES;
    }
    if (model.user.honorTitleIconUrl.length) {
        [self.honorIcon sd_setImageWithURL:[NSURL URLWithString:model.user.honorTitleIconUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    } else {
        self.honorIcon.image = nil;
    }
    if (model.likeFlag.integerValue == 0) {
        [self.likeButton setImage:[UIImage imageNamed:@"icon_origin_circle_not_like"] forState:UIControlStateNormal];
    } else if (model.likeFlag.integerValue == 1) {
        [self.likeButton setImage:[UIImage imageNamed:@"icon_origin_circle_like"] forState:UIControlStateNormal];
    }
    NSInteger sortOfImages = 0;
    for (NSString *obj in model.images) {
        __strong typeof(obj) sObj = obj;
        switch (sortOfImages) {
            case 0:
                if (model.images.count == 1) {
                    [self.firstImg sd_setImageWithURL:[NSURL URLWithString:sObj] placeholderImage:[UIImage imageNamed:@"img_origin_circle_topic_placeholder_big.jpg"]];
                } else {
                    [self.firstImg sd_setImageWithURL:[NSURL URLWithString:sObj] placeholderImage:[UIImage imageNamed:@"img_origin_circle_topic_placeholder_small.jpg"]];
                }
                break;
            case 1: {
                if (self.secondImg == nil) {
                    UIImageView *img = [[UIImageView alloc] init];
                    [self.contentView addSubview:img];
                    self.secondImg = img;
                    self.secondImg.clipsToBounds = YES;
                    self.secondImg.contentMode = UIViewContentModeScaleAspectFill;
                }
                [self.secondImg sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"img_origin_circle_topic_placeholder_small.jpg"]];
            }
                break;
            case 2: {
                if (self.thirdImg == nil) {
                    UIImageView *img = [[UIImageView alloc] init];
                    [self.contentView addSubview:img];
                    self.thirdImg = img;
                    self.thirdImg.clipsToBounds = YES;
                    self.thirdImg.contentMode = UIViewContentModeScaleAspectFill;
                }
                [self.thirdImg sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"img_origin_circle_topic_placeholder_small.jpg"]];
            }
                break;
                
            default:
                break;
        }
        sortOfImages ++;
    }
    
    //        self.titleLabel.text = MSLocalizedString(model.title, nil);
    //        [self.titleLabel sizeToFit];
    self.titleLabel.text = model.title;
    if (!model.title.length) {
        [self.titleLabel setInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    } else {
        [self.titleLabel setInsets:UIEdgeInsetsMake(8, 0, 0, 0)];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:MSLocalizedString(model.text, nil) attributes:@{NSFontAttributeName:YDF_SYS(15.f), NSForegroundColorAttributeName:YDC_TITLE}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.text length])];
    self.detailLabel.attributedText = attributedString;
    if (!model.text.length) {
        [self.detailLabel setInsets:UIEdgeInsetsZero];
    } else {
        if (model.title.length) {
            [self.detailLabel setInsets:UIEdgeInsetsMake(2, 0, 0, 0)];
        } else {
            [self.detailLabel setInsets:UIEdgeInsetsMake(8, 0, 0, 0)];
        }
    }
    //        [self.detailLabel sizeToFit];
    self.areaLabel.text = MSLocalizedString(model.area, nil);
    if (model.area.length) {
        [self.areaLabel setInsets:UIEdgeInsetsMake(8, 0, 0, 0)];
    } else {
        [self.areaLabel setInsets:UIEdgeInsetsZero];
    }
    [self.typeIcon sd_setImageWithURL:[NSURL URLWithString:model.circle.icon]];
    self.typeLabel.text = MSLocalizedString(model.circle.name, nil);
    NSString *commentCount = [NSString stringWithFormat:@"%ld",(long)model.commentCount];
//    self.discussCountLabel.text = MSLocalizedString(commentCount, nil);
    [self.discussButton setTitle:MSLocalizedString(commentCount, nil) forState:UIControlStateNormal];
    NSString *likeCount = [NSString stringWithFormat:@"%ld",(long)model.likeCnt];
    self.likeCountLabel.text = MSLocalizedString(likeCount, nil);
    if (model.user.followStatus.integerValue == 0) {
        self.followBtn.hidden = NO;
    } else {
        self.followBtn.hidden = YES;
    }
    if (model.videoUrlArr.count && model.images.count == 1) {
        if (self.playVideoImg == nil) {
            UIImageView *img = [[UIImageView alloc] init];
            [self.contentView addSubview:img];
            self.playVideoImg = img;
        }
        self.playVideoImg.image = [UIImage imageNamed:@"icon_origin_circle_play"];
        if (self.videoTimeLabel == nil) {
            UILabel *label = [[UILabel alloc] init];
            [self.contentView addSubview:label];
            self.videoTimeLabel = label;
        }
        self.videoTimeLabel.textColor = [UIColor whiteColor];
        self.videoTimeLabel.font = YDF_SYS(13);
        self.videoTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",model.videoTime / 60,model.videoTime % 60];
        if (self.playVideoImg) {
            [self.playVideoImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.firstImg);
            }];
        }
        if (self.videoTimeLabel) {
            [self.videoTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.firstImg.mas_right).offset(kVideoTimeLabelRight);
                make.bottom.equalTo(self.firstImg.mas_bottom).offset(kVideoTimeLabelBottom);
            }];
        }
    } else {
        [self.playVideoImg removeFromSuperview];
        self.playVideoImg = nil;
        [self.videoTimeLabel removeFromSuperview];
        self.videoTimeLabel = nil;
    }
    
    if (model.param.length) {
        self.watchCountLabel.text = [NSString stringWithFormat:@"%@",@(model.viewCount)];
        self.statusView.hidden = NO;
        self.watchCountLabel.hidden = NO;
        self.watchIcon.hidden = NO;
        self.likeButton.hidden = YES;
        self.likeCountLabel.hidden = YES;
        self.discussButton.hidden = YES;
//        self.discussIcon.hidden = YES;
//        self.discussCountLabel.hidden = YES;
    } else {
        self.statusView.hidden = YES;
        self.watchCountLabel.hidden = YES;
        self.watchIcon.hidden = YES;
        self.likeButton.hidden = NO;
        self.likeCountLabel.hidden = NO;
        self.discussButton.hidden = NO;
//        self.discussIcon.hidden = NO;
//        self.discussCountLabel.hidden = NO;
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
    //    }
}
- (void)addSubviews {
    if (self.userIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.userIcon = img;
    }
    if (self.nickNameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.nickNameLabel = label;
    }
    if (self.levelLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.levelLabel = label;
    }
    if (self.sexIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.sexIcon = img;
    }
    if (self.talentIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.talentIcon = img;
    }
    if (self.honorContainer == nil) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.honorContainer = view;
    }
    if (self.honorIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.honorContainer addSubview:img];
        self.honorIcon = img;
    }
    if (self.honorTitleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.honorContainer addSubview:label];
        self.honorTitleLabel = label;
    }

    
    if (self.followBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        self.followBtn = btn;
    }
    if (self.firstImg == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.firstImg = img;
    }
    if (self.secondImg == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.secondImg = img;
    }
    if (self.thirdImg == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.thirdImg = img;
    }
    
    if (self.titleLabel == nil) {
        YDInsetLabel *label = [[YDInsetLabel alloc] initWithEdgeInsets:UIEdgeInsetsMake(8, 0, 0, 0)];
        [self.contentView addSubview:label];
        self.titleLabel = label;
    }
    if (self.detailLabel == nil) {
        YDInsetLabel *label = [[YDInsetLabel alloc] initWithEdgeInsets:UIEdgeInsetsMake(2, 0, 0, 0)];
        [self.contentView addSubview:label];
        self.detailLabel = label;
    }
    if (self.areaLabel == nil) {
        YDInsetLabel *label = [[YDInsetLabel alloc] initWithEdgeInsets:UIEdgeInsetsMake(8, 0, 0, 0)];
        [self.contentView addSubview:label];
        self.areaLabel = label;
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
    
    if (self.discussButton == nil) {
        UIButton *discussButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [discussButton addTarget:self action:@selector(discussAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:discussButton];
        self.discussButton = discussButton;
    }
    
//    if (self.discussIcon == nil) {
//        UIImageView *img = [[UIImageView alloc] init];
//        [self.contentView addSubview:img];
//        self.discussIcon = img;
//    }
//    if (self.discussCountLabel == nil) {
//        UILabel *label = [[UILabel alloc] init];
//        [self.contentView addSubview:label];
//        self.discussCountLabel = label;
//    }
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
    if (self.likeAnimationLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.likeAnimationLabel = label;
    }
    if (self.bottomLineView == nil) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.bottomLineView = view;
    }
    if (self.watchIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.watchIcon = img;
    }
    if (self.watchCountLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.watchCountLabel = label;
    }
    if (self.statusView == nil) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.statusView = view;
    }
    if (self.livingCirclePoint == nil) {
        UIView *view = [[UIView alloc] init];
        [self.statusView addSubview:view];
        self.livingCirclePoint = view;
    }
    if (self.statusLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.statusView addSubview:label];
        self.statusLabel = label;
    }
}

- (void)styleInit {
    self.userIcon.layer.cornerRadius = kUserIconWH / 2;
    self.userIcon.clipsToBounds = YES;
    self.nickNameLabel.textColor = RGBA(102, 102, 102, 1);
    self.levelLabel.textColor = RGBA(28, 192, 25, 1);
    self.honorContainer.layer.cornerRadius = 2.f;
    self.honorContainer.layer.masksToBounds = YES;
    self.honorContainer.backgroundColor = YD_RGBA(255, 141, 75, 1);
    self.honorTitleLabel.textColor = YD_WHITE(1);
    self.talentIcon.image = [UIImage imageNamed:@"icon_circle_intelligent"];
    self.followBtn.backgroundColor = YD_GRAY(245);
    [self.followBtn setTitleColor:YDC_G forState:UIControlStateNormal];
    [self.followBtn setTitle:MSLocalizedString(@"关注", nil) forState:UIControlStateNormal];
    [self.followBtn addTarget:self action:@selector(userFollow) forControlEvents:UIControlEventTouchUpInside];
    self.followBtn.titleLabel.font = YDF_CUS(YDFontPFangMedium, 12);
    self.followBtn.hidden = YES;
    
    
    self.firstImg.clipsToBounds = YES;
    self.secondImg.clipsToBounds = YES;
    self.thirdImg.clipsToBounds = YES;
    self.firstImg.contentMode = UIViewContentModeScaleAspectFill;
    self.secondImg.contentMode = UIViewContentModeScaleAspectFill;
    self.thirdImg.contentMode = UIViewContentModeScaleAspectFill;
    
    self.titleLabel.textColor = YDC_TITLE;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.textColor = YDC_TITLE;
    self.detailLabel.numberOfLines = 2;
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    
    self.areaLabel.textColor = YD_RGB( 87, 107, 149);
    self.areaLabel.font = YDF_SYS(13);
    self.typeIcon.layer.cornerRadius = kTypeIconWH / 2;
    self.typeIcon.clipsToBounds = YES;
    self.typeLabel.textColor = YD_RGB(102, 102, 102);
    self.typeLabel.font = YDF_SYS(13);
    
    self.discussButton.imageEdgeInsets = UIEdgeInsetsMake(0, kDiscussIconRight, 0, -kDiscussIconRight);
    [self.discussButton setImage:[UIImage imageNamed:@"icon_origin_circle_comment"] forState:UIControlStateNormal];
    [self.discussButton setTitleColor:YDC_TEXT forState:UIControlStateNormal];
    
//    self.discussIcon.image = [UIImage imageNamed:@"icon_origin_circle_comment"];
//    self.discussIcon.userInteractionEnabled = YES;
//    UITapGestureRecognizer *discussImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDiscussImageTapGestureRecognizer:)];
//    [self.discussIcon addGestureRecognizer:discussImageTap];
    
    [self.likeButton setImage:[UIImage imageNamed:@"icon_origin_circle_not_like"] forState:UIControlStateNormal];
    self.likeButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.likeButton addTarget:self action:@selector(operateTopic) forControlEvents:UIControlEventTouchUpInside];
//    self.discussCountLabel.textColor = YDC_TEXT;
    self.likeCountLabel.textColor = YDC_TEXT;
    self.bottomLineView.backgroundColor = YDC_SP;
    
    self.likeAnimationLabel.text = MSLocalizedString(@"+1", nil);
    self.likeAnimationLabel.textColor = YD_RGB(255,  89,  89);
    self.likeAnimationLabel.font = YDF_SYS(13);
    self.likeAnimationLabel.alpha = 0;
    
    self.watchCountLabel.textColor = YDC_TEXT;
    self.statusView.layer.cornerRadius = kStatusViewHeight / 2;
    self.statusView.layer.borderColor = YD_RGBA(255, 255, 255, 0.4f).CGColor;
    self.statusView.layer.borderWidth = 1.f;
    self.statusView.backgroundColor = YD_RGBA(0, 0, 0, 0.3);
    self.livingCirclePoint.layer.cornerRadius = kLivingCirclePointWH / 2;
    self.livingCirclePoint.backgroundColor = YD_RGBA(5, 255, 0, 1);
    self.statusLabel.textColor = [UIColor whiteColor];
    self.statusLabel.font = YDF_SYS(11.f);
    self.statusLabel.text = MSLocalizedString(@"直播", nil);
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.watchIcon.image = [UIImage imageNamed:@"icon_circle_browse"];
    
    self.statusView.hidden = YES;
    
    if ([[UIDevice currentDevice] systemVersion].floatValue < 9.0) {
        self.nickNameLabel.font = YDF_SYS(14.f);
        self.levelLabel.font = YDF_SYS(12.f);
        self.titleLabel.font = YDF_SYS_B(17.f);
        self.likeCountLabel.font = YDF_SYS(13.f);
        self.discussButton.titleLabel.font = YDF_SYS(13);
//        self.discussCountLabel.font = YDF_SYS(13);
        self.watchCountLabel.font = YDF_SYS_B(13.f);
        self.honorTitleLabel.font = YDF_SYS(11.f);
    } else {
        self.nickNameLabel.font = YDF_CUS(YDFontPFangMedium, 14.f);
        self.levelLabel.font = YDF_CUS(YDFontPFangMedium, 12.f);
        self.titleLabel.font = YDF_CUS(YDFontPFangSemibold, 17.f);
        self.likeCountLabel.font = YDF_CUS(YDFontPFangMedium, 13.f);
        self.discussButton.titleLabel.font = YDF_CUS(YDFontPFangMedium, 13.f);
//        self.discussCountLabel.font = YDF_CUS(YDFontPFangMedium, 13.f);
        self.watchCountLabel.font = YDF_CUS(YDFontPFangSemibold, 13.f);
        self.honorTitleLabel.font = YDF_CUS(YDFontPFangMedium, 11.f);
    }
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kUserIconTop);
        make.left.equalTo(self.contentView).offset(kUserIconLeft);
        make.width.height.mas_equalTo(kUserIconWH);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(knickNameLabelLeft);
        make.top.equalTo(self.contentView).offset(knickNameLabelTop);
    }];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(kLevelLabelTop);
    }];
    [self.sexIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel.mas_right).offset(kSexIconLeft);
        make.centerY.equalTo(self.nickNameLabel);
        make.height.width.mas_equalTo(kSexIconWH);
    }];
    if (self.talentIcon) {
        [self.talentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sexIcon.mas_right).offset(6.f);
            make.centerY.equalTo(self.nickNameLabel);
            make.height.with.mas_equalTo(kSexIconWH);
        }];
    }
    if (self.honorContainer) {
        [self.honorContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.talentIcon.mas_right).offset(6.f);
            make.centerY.equalTo(self.nickNameLabel);
            make.height.mas_equalTo(kSexIconWH);
        }];
    }
    if (self.honorIcon) {
        [self.honorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.honorContainer).offset(3.f);
            make.top.equalTo(self.honorContainer).offset(3.f);
            make.height.mas_equalTo(10.f);
            make.width.mas_equalTo(10.f);
        }];
    }
    if (self.honorTitleLabel) {
        [self.honorTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.honorIcon.mas_right).offset(3.f);
            make.top.bottom.equalTo(self.honorContainer);
            make.right.equalTo(self.honorContainer).offset(-4.f).priorityHigh();
        }];
    }
    if (self.followBtn) {
        [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(kFollowBtnRight);
            make.top.equalTo(self.contentView).offset(kFollowBtnTop);
            make.width.mas_equalTo(kFollowBtnW);
            make.height.mas_equalTo(kFollowBtnH);
        }];
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kTitleLabelLeft);
        make.right.equalTo(self.contentView).offset(-kTitleLabelLeft);
        make.top.equalTo(self.userIcon.mas_bottom);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kDetailLabelLeft);
        make.right.equalTo(self.contentView).offset(-kDetailLabelLeft);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    [self.firstImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kFirstImgLeft);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(0.f);
        make.width.height.mas_equalTo(0.f);
    }];
    [self.secondImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstImg);
        make.width.height.equalTo(self.firstImg);
        make.left.equalTo(self.firstImg.mas_right).offset(kPadding);
    }];
    [self.thirdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstImg);
        make.width.height.equalTo(self.firstImg);
        make.left.equalTo(self.secondImg.mas_right).offset(kPadding);
    }];
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstImg.mas_bottom);
        make.left.equalTo(self.contentView).offset(kAreaLabelLeft);
        make.right.lessThanOrEqualTo(self.contentView.mas_centerX);
    }];
    [self.typeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kTypeIconLeft);
        make.top.equalTo(self.areaLabel.mas_bottom).offset(kTypeIconTop);
        make.height.width.mas_equalTo(kTypeIconWH);
        make.bottom.equalTo(self.contentView).offset(-kBottomViewTop).priorityHigh();
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(YDSP_WIDTH);
        make.bottom.equalTo(self.contentView);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeIcon.mas_right).offset(kTypeLabelLeft);
        make.right.lessThanOrEqualTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.typeIcon);
    }];
    
    [self.discussButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(kDiscussCountLabelRight);
        make.centerY.equalTo(self.typeIcon);
    }];
//    [self.discussCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView.mas_right).offset(kDiscussCountLabelRight);
//        make.centerY.equalTo(self.typeIcon);
//    }];
//    [self.discussIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.discussCountLabel.mas_left).offset(kDiscussIconRight);
//        make.centerY.equalTo(self.typeIcon);
//    }];
    if (self.likeCountLabel) {
        [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.typeIcon);
            make.right.equalTo(self.discussButton.mas_left).offset(kLikeCountLabelRight);
        }];
    }
    if (self.likeButton) {
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.typeIcon);
            make.right.equalTo(self.likeCountLabel.mas_left).offset(kLikeButtonRight);
        }];
    }
    if (self.likeAnimationLabel) {
        [self.likeAnimationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.likeCountLabel.mas_right);
            make.bottom.equalTo(self.likeCountLabel.mas_top);
        }];
    }
    
    //live
    if (self.watchCountLabel) {
        [self.watchCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-12.f);
            make.centerY.equalTo(self.typeIcon);
        }];
    }
    if (self.watchIcon) {
        [self.watchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.watchCountLabel.mas_left).offset(-6.f);
            make.centerY.equalTo(self.typeIcon);
        }];
    }
    if (self.statusView) {
        [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.firstImg).offset(kStatusViewRight);
            make.top.equalTo(self.firstImg).offset(kStatusViewTop);
            make.width.mas_equalTo(kStatusViewWidth);
            make.height.mas_equalTo(kStatusViewHeight);
        }];
    }
    if (self.livingCirclePoint) {
        [self.livingCirclePoint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.statusView).offset(kLivingCirclePointLeft);
            make.centerY.equalTo(self.statusView);
            make.width.height.mas_equalTo(kLivingCirclePointWH);
        }];
    }
    if (self.statusLabel) {
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.livingCirclePoint.mas_right).offset(kStatusLabelLeft);
            make.centerY.equalTo(self.statusView);
        }];
    }
}

- (void)updateConstraints {
    CGFloat talentIconLeft = 0.f;
    CGFloat talentIconWh = 0.f;
    if (self.model.user.talentTitle.length) {
        talentIconLeft = 6.f;
        talentIconWh = 16.f;
    }
    if (self.talentIcon) {
        [self.talentIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sexIcon.mas_right).offset(talentIconLeft);
            make.width.height.mas_equalTo(talentIconWh);
            make.centerY.equalTo(self.nickNameLabel);
        }];
    }
   
    CGFloat imgHeight = 0.f;
    CGFloat imgWidth = 0.f;
    CGFloat padding = 0.f;
    CGFloat imgTop = 8.f;
    if (self.model.param.length) {
        if (self.model.images.count == 1) {
            imgWidth = SCREEN_WIDTH_V0 * 205.f / 375;
            imgHeight = imgWidth;
            padding = 0.f;
        } else {
            imgHeight = 0.f;
            imgTop = 0.f;
        }
    } else if (self.model.videoUrlArr.count) {
        if (self.model.images.count == 1) {
            imgWidth = SCREEN_WIDTH_V0 - 2 * kFirstImgLeft ;
            imgHeight = imgWidth * (150.f/350);
            padding = 0.f;
        } else {
            imgHeight = 0.f;
            imgTop = 0.f;
        }
    } else {
        switch (self.model.images.count) {
            case 0:
                imgHeight = 0.f;
                imgTop = 0.f;
                break;
            case 1:
                imgWidth = DEVICE_WIDTH_OF(230.f);
                imgHeight = imgWidth;
                padding = 0.f;
                break;
            case 2:
                padding = 8.f;
                imgWidth = (CGFloat)(SCREEN_WIDTH_V0 - 2 * kFirstImgLeft - padding)/2;
                imgHeight = imgWidth * (126.f/175);
                break;
            case 3:
                padding = 2.f;
                imgWidth = (CGFloat)(SCREEN_WIDTH_V0 - 2 * kFirstImgLeft - 2 * padding)/3;
                imgHeight = imgWidth;
                break;
            default:
                break;
        }
    }
    if (self.firstImg != nil) {
        [self.firstImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kFirstImgLeft);
            make.top.equalTo(self.detailLabel.mas_bottom).offset(imgTop);
            make.width.mas_equalTo(imgWidth);
            make.height.mas_equalTo(imgHeight);
        }];
    }
    if (self.secondImg != nil) {
        [self.secondImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstImg);
            make.width.height.equalTo(self.firstImg);
            make.left.equalTo(self.firstImg.mas_right).offset(padding);
        }];
    }
    if (self.thirdImg != nil) {
        [self.thirdImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstImg);
            make.width.height.equalTo(self.firstImg);
            make.left.equalTo(self.secondImg.mas_right).offset(padding);
        }];
    }
    
    
    [super updateConstraints];
}

/*
 * 关注操作
 */
- (void)userFollow {
    !_userFollowAction ?: _userFollowAction([YDAppInstance userId], self.model.user.userId);
}
/*
 * 点赞操作
 */
- (void)operateTopic {
    !_userLikeAction ?: _userLikeAction();
}

- (void)discussAction {
    !_userDiscussAction?:_userDiscussAction();
}
//- (void)handleDiscussImageTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
//    !_userDiscussAction?:_userDiscussAction();
//}



@end
