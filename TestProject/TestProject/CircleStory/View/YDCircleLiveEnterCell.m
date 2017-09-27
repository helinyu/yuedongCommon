//
//  YDCircleLiveEnterCell.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCircleLiveEnterCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface YDCircleLiveEnterCell ()
@property (nonatomic,   weak) UIView *imagesContainer;
@property (nonatomic, strong) NSMutableArray *imageViewsArr;

@end
@implementation YDCircleLiveEnterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self comInit];
        [self createConstraints];
        [self styleInit];
    }
    return self;
}

- (void)setImagesArr:(NSMutableArray<NSString *> *)imagesArr {
    if (_imagesArr == nil) {
        _imagesArr = [NSMutableArray array];
        [_imagesArr addObjectsFromArray:imagesArr];
    }
    NSInteger max = (imagesArr.count > 5) ? 5 : imagesArr.count;
    for (NSInteger i = 0; i < max; i ++) {
        UIImageView *imageView = [self.imageViewsArr objectAtIndex:i];
        NSString *urlStr = [imagesArr objectAtIndex:i];
        [imageView sd_setImageWithURL:[NSURL yd_URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"icon_circle_live_place"]];
    }
}
- (void)comInit {
    if (self.imagesContainer == nil) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.imagesContainer = view;
    }
    for (NSInteger i = 0; i < 5; i ++) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.imagesContainer addSubview:img];
        [self.imageViewsArr addObject:img];
        img.contentMode = UIViewContentModeScaleAspectFill;
    }
}

- (void)createConstraints {
    [self.imageViewsArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:8 leadSpacing:12 tailSpacing:12];
    [self.imageViewsArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.imagesContainer);
    }];
    if (self.imagesContainer) {
        [self.imagesContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(12.f);
            make.bottom.equalTo(self.contentView).offset(-12.f);
            make.left.right.equalTo(self.contentView);
        }];
    }
}

- (void)styleInit {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.imagesContainer.backgroundColor = [UIColor whiteColor];
}

- (NSMutableArray *)imageViewsArr {
    if (_imageViewsArr == nil) {
        _imageViewsArr = [NSMutableArray array];
    }
    return _imageViewsArr;
}
@end
