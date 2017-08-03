//
//  HLyTestCollectionViewCell.m
//  test
//
//  Created by felix on 2017/6/7.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLyTestCollectionViewCell.h"

@implementation HLyTestCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (_titleLabel == nil) {
            _titleLabel = [UILabel new];
            _titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)/5 *2);
            [self addSubview:_titleLabel];
        }
        
        if (_descriptionLabel == nil) {
            _descriptionLabel = [UILabel new];
            _descriptionLabel.frame = CGRectMake(0, CGRectGetHeight(frame)/5 *3, CGRectGetWidth(self.bounds), CGRectGetHeight(frame)/5 *2);
            [self addSubview:_descriptionLabel];
        }
    }
    return self;
}

@end
