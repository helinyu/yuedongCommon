//
//  YDCircleAdCell.m
//  SportsBar
//
//  Created by 张旻可 on 29/03/2017.
//  Copyright © 2017 apple. All rights reserved.
//

#import "YDCircleAdCell.h"

#import "YDInsetLabel.h"

#import "YDAd.h"
#import "YDAdImg.h"
#import "YDAdNative.h"
#import "YDAdTitle.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "YDAdMgr.h"

@interface YDCircleAdCell ()

@property (nonatomic, strong) YDInsetLabel *titleLabel;
@property (nonatomic, strong) YDInsetLabel *descLabel;
@property (nonatomic, strong) UIImageView *adImgView;
@property (nonatomic, strong) YDInsetLabel *adTag;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong, readwrite) YDAd *model;
@property (nonatomic, weak, readwrite) UICollectionView *collection;

@property (nonatomic, weak) id<SDWebImageOperation> operation;

@end

@implementation YDCircleAdCell

+ (YDCircleAdCell *)reusableCellForCollectionView:(UICollectionView *)collectionView cellId:(NSString *)cell_id indexPath:(NSIndexPath *)index_path model:(YDAd *)model {
    YDCircleAdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:index_path];
    cell.model = model;
    cell.collection = collectionView;
    return cell;
}

- (void)setModel:(YDAd *)model {
    _model = model;
    __weak typeof(self) wSelf = self;
    if (model.adImg) {
        self.adImgView.image = model.adImg;
    } else {
        self.adImgView.image = [UIImage imageNamed:@"img_origin_circle_topic_placeholder_big.jpg"];
        if (self.operation) {
            [self.operation cancel];
        }
        self.operation = [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:model.native.img.url] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!error && image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([[wSelf.collection visibleCells] containsObject:wSelf] &&
                        [wSelf.model isEqual:model] &&
                        wSelf.frame.origin.y + wSelf.model.circleCellHeight <= wSelf.collection.contentOffset.y + SCREEN_HEIGHT_V0 - YDTabBarH) {
                        [[YDAdMgr sharedMgr] yd_handleAdShow:model];
                    }
//                    UIImage *img = [image imageClipWithRatio:model.native.img.ratio.floatValue];
                    model.adImg = image;
                    if ([model isEqual:wSelf.model]) {
                        wSelf.adImgView.image = model.adImg;
                    }
                });
                
            }
        }];
    }
    [self.adImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_WIDTH_V0 * 0.693 / model.native.img.ratio.floatValue);
    }];
    
    self.titleLabel.text = model.native.title.text;
    self.descLabel.text = model.native.subTitle;
    if (model.native.title.text.length) {
        [self.titleLabel setInsets:UIEdgeInsetsMake(YDMargin14, 0, 0, 0)];
    } else {
        [self.titleLabel setInsets:UIEdgeInsetsZero];
    }
    if (model.native.subTitle.length) {
        [self.descLabel setInsets:UIEdgeInsetsMake(YDMargin8, 0, 0, 0)];
    } else {
        [self.descLabel setInsets:UIEdgeInsetsZero];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
    }
    return self;
}

- (void)comInit {
    self.titleLabel = [[YDInsetLabel alloc] init];
    self.descLabel = [[YDInsetLabel alloc] init];
    self.adImgView = [[UIImageView alloc] init];
    self.adTag = [[YDInsetLabel alloc] init];
    self.bottomLine = [[UIView alloc] init];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.adImgView];
    [self.contentView addSubview:self.adTag];
    [self.contentView addSubview:self.bottomLine];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(YDMargin12);
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-YDMargin12);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(YDMargin12);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.contentView).offset(-YDMargin12);
    }];
    [self.adImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(YDMargin12);
        make.top.equalTo(self.descLabel.mas_bottom).offset(YDMargin8);
        make.width.mas_equalTo(SCREEN_WIDTH_V0 * 0.693);
    }];
    [self.adTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(YDMargin12);
        make.top.equalTo(self.adImgView.mas_bottom).offset(YDMargin12);
        make.bottom.equalTo(self.contentView).offset(-YDMargin14);
        make.height.mas_equalTo(20);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(YDSP_WIDTH);
    }];
    
    self.titleLabel.font = YDF_SYS_B(17);
    self.titleLabel.textColor = YD_GRAY(51);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel setInsets:UIEdgeInsetsMake(YDMargin14, 0, 0, 0)];
    
    self.descLabel.font = YDF_SYS(15);
    self.descLabel.textColor = YD_GRAY(51);
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    self.descLabel.numberOfLines = 0;
    [self.descLabel setInsets:UIEdgeInsetsMake(YDMargin8, 0, 0, 0)];
    
    self.adImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.adImgView.clipsToBounds = YES;
    
    self.adTag.font = YDF_SYS(13);
    self.adTag.textColor = YD_GRAY(102);
    self.adTag.textAlignment = NSTextAlignmentCenter;
    self.adTag.numberOfLines = 1;
    [self.adTag setInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
    self.adTag.backgroundColor = YD_GRAY(216);
    
    self.bottomLine.backgroundColor = YDC_SP;
    
//    UIView *v = [[UIView alloc] init];
//    v.backgroundColor = YDC_BG;
//    self.selectedBackgroundView = v;
    
    self.adTag.text = MSLocalizedString(@"广告", nil);
}

@end
