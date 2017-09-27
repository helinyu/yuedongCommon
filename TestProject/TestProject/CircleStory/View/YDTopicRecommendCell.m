//
//  YDTopicRecommendCell.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDTopicRecommendCell.h"
#import "YDTopicRecommendInfo.h"
#import "YDTopicRecommendItem.h"

static NSString *const kRecommendItem = @"kRecommendItem";

@interface YDTopicRecommendCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *addIcon;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic,   weak) UIButton *checkMoreBtn;
@property (nonatomic,   weak) UIImageView *checkIcon;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *lineView;

@end
@implementation YDTopicRecommendCell

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
- (void)setRecommendInfos:(NSArray<YDTopicRecommendInfo *> *)recommendInfos {
    _recommendInfos = [NSArray arrayWithArray:recommendInfos];
    [self.collectionView reloadData];
}
- (void)comInit {
    if (self.addIcon == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.addIcon = img;
    }
    if (self.recommendLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.recommendLabel = label;
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

    if (self.collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(DEVICE_WIDTH_OF(148.f), DEVICE_WIDTH_OF(148.f) * 192.f / 148.f);
        layout.minimumLineSpacing = 10.f;
        layout.minimumInteritemSpacing = 10.f;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
    }
    if (self.lineView == nil) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.lineView = view;
    }
}

- (void)createConstraints {
    if (self.addIcon) {
        [self.addIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15.f);
            make.left.equalTo(self.contentView).offset(12.f);
            make.width.height.mas_equalTo(40.f);
        }];
    }
    if (self.recommendLabel) {
        [self.recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.addIcon);
            make.left.equalTo(self.addIcon.mas_right).offset(8.f);
        }];
    }
    [self.checkIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.recommendLabel);
    }];
    [self.checkMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.recommendLabel);
        make.right.equalTo(self.checkIcon.mas_left).offset(-6);
    }];
    
    [self.checkMoreBtn addTarget:self action:@selector(checkMore) forControlEvents:UIControlEventTouchUpInside];

    if (self.collectionView) {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addIcon.mas_bottom).offset(14.f);
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(DEVICE_WIDTH_OF(148.f) * 192.f / 148.f);
        }];
    }
    if (self.lineView) {
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(YDSP_WIDTH);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
}

- (void)styleInit {
    self.addIcon.image = [UIImage imageNamed:@"icon_circle_recommend"];
    self.addIcon.contentMode = UIViewContentModeScaleToFill;
    self.addIcon.layer.masksToBounds = YES;
    self.addIcon.layer.cornerRadius = 20.f;
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        self.recommendLabel.font = YDF_SYS(15.f);
    } else {
        self.recommendLabel.font = YDF_CUS(YDFontPFangMedium, 15.f);
    }
    self.recommendLabel.textColor = YDC_TITLE;
    self.recommendLabel.text = MSLocalizedString(@"用户推荐", nil);
    self.checkMoreBtn.titleLabel.font = YDF_SYS(12.f);
    [self.checkMoreBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
    NSString *string = MSLocalizedString(@"查看全部", nil);
    [self.checkMoreBtn setTitle:string forState:UIControlStateNormal];
    self.checkIcon.image = [UIImage imageNamed:@"icon_origin_circle_all"];
    
    
    self.lineView.backgroundColor = YDC_SP;
    self.collectionView.backgroundColor = YD_WHITE(1);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.collectionView registerClass:[YDTopicRecommendItem class] forCellWithReuseIdentifier:kRecommendItem];
}

#pragma mark - UICollectionViewDataSource UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recommendInfos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDTopicRecommendItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRecommendItem forIndexPath:indexPath];
    cell.model = self.recommendInfos[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YDTopicRecommendInfo *info = self.recommendInfos[indexPath.item];
    !self.actionToUserInfoVc ?:self.actionToUserInfoVc(info.userId.integerValue);
}
- (void)checkMore {
    !_action ?:_action();
}
@end
