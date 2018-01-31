//
//  YDCustomCollectionViewCell.m
//  TestCoreText
//
//  Created by mac on 31/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDCustomCollectionViewCell.h"
#import "Masonry.h"

@implementation YDCustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [UILabel new];
        [self.contentView addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

@end
