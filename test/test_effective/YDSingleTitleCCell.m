
//
//  YDSingleTitleCCell.m
//  test_effective
//
//  Created by Aka on 2017/10/29.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDSingleTitleCCell.h"
#import "Masonry.h"

@interface YDSingleTitleCCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YDSingleTitleCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

@end
