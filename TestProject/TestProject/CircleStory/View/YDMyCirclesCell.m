//
//  YDMyCirclesCell.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDMyCirclesCell.h"
#import "YDSingleCircleView.h"
#import "YDOriginCircleModel.h"
#import "UIImageView+WebCache.h"
#import "YDImageControl.h"

static const CGFloat kFirstCircleLeft = 0.f;
static const CGFloat kFirstCircleHeight = 69;
static const CGFloat kFirstCircleTop = 12;


@interface YDMyCirclesCell ()
@property (nonatomic,   weak) UIView *bottomView;
@end

@implementation YDMyCirclesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCircles:(NSArray<YDOriginCircleModel *> *)circles {
    _circles = circles;
    
    NSInteger sortOfImages = 0;
    for (YDOriginCircleModel *obj in circles) {
        switch (sortOfImages) {
            case 0: {
                self.firstCircle.titleLabel.text = MSLocalizedString(obj.name, nil);
                [self.firstCircle.imageControl.icon sd_setImageWithURL:[NSURL yd_URLWithString:obj.icon] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];
            }
                break;
            case 1: {
                self.secondCircle.titleLabel.text = MSLocalizedString(obj.name, nil);
                [self.secondCircle.imageControl.icon sd_setImageWithURL:[NSURL yd_URLWithString:obj.icon] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];
            }
                break;
            case 2: {
                self.thirdCircle.titleLabel.text = MSLocalizedString(obj.name, nil);
                [self.thirdCircle.imageControl.icon sd_setImageWithURL:[NSURL yd_URLWithString:obj.icon] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];
            }
                break;
            case 3: {
                self.fourthCircle.titleLabel.text = MSLocalizedString(obj.name, nil);
                [self.fourthCircle.imageControl.icon sd_setImageWithURL:[NSURL yd_URLWithString:obj.icon] placeholderImage:[UIImage imageNamed:@"img_origin_circle_mycircle_placeholder.jpg"]];
            }
                break;
            default:
                break;
        }
        sortOfImages ++;
    }
    [self setNeedsUpdateConstraints];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    if (self.firstCircle == nil) {
        YDSingleCircleView *view = [[YDSingleCircleView alloc] initWithType:YDCellSingleViewTypeCircle frame:CGRectZero];
        [self.contentView addSubview:view];
        self.firstCircle = view;
    }
    if (self.secondCircle == nil) {
        YDSingleCircleView *view = [[YDSingleCircleView alloc] initWithType:YDCellSingleViewTypeCircle frame:CGRectZero];
        [self.contentView addSubview:view];
        self.secondCircle = view;
    }
    if (self.thirdCircle == nil) {
        YDSingleCircleView *view = [[YDSingleCircleView alloc] initWithType:YDCellSingleViewTypeCircle frame:CGRectZero];
        [self.contentView addSubview:view];
        self.thirdCircle = view;
    }
    if (self.fourthCircle == nil) {
        YDSingleCircleView *view = [[YDSingleCircleView alloc] initWithType:YDCellSingleViewTypeCircle frame:CGRectZero];
        [self.contentView addSubview:view];
        self.fourthCircle = view;
    }

    CGFloat height = self.circles.count ? kFirstCircleHeight : kFirstCircleHeight;
    CGFloat top = self.circles.count ? kFirstCircleTop : kFirstCircleHeight;
    CGFloat CircleWidth = (SCREEN_WIDTH_V0 - 2 * kFirstCircleLeft) / 4;
    [self.firstCircle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kFirstCircleLeft);
        make.top.equalTo(self.contentView).offset(top);
        make.width.mas_equalTo(CircleWidth);
        make.height.mas_equalTo(height);
    }];
    
    [self.secondCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstCircle.mas_right);
        make.width.height.top.equalTo(self.firstCircle);
    }];
    [self.thirdCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondCircle.mas_right);
        make.top.width.height.equalTo(self.firstCircle);
    }];
    [self.fourthCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdCircle.mas_right);
        make.top.width.height.equalTo(self.firstCircle);
    }];
    [self styleInit];
    
}
- (void)styleInit {

}

- (void)updateConstraints {
   
    CGFloat height = self.circles.count ? kFirstCircleHeight : kFirstCircleHeight;
    CGFloat top = self.circles.count ? kFirstCircleTop : kFirstCircleHeight;
    CGFloat CircleWidth = (SCREEN_WIDTH_V0 - 2 * kFirstCircleLeft) / 4;
    [self.firstCircle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kFirstCircleLeft);
        make.top.equalTo(self.contentView).offset(top);
        make.width.mas_equalTo(CircleWidth);
        make.height.mas_equalTo(height);
    }];
    [super updateConstraints];
}



@end
