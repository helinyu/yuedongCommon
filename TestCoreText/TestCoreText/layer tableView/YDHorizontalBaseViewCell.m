//
//  YDHorizontalBaseViewCell.m
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHorizontalBaseViewCell.h"
#import "Masonry.h"

@interface YDHorizontalBaseViewCell ()


@end

@implementation YDHorizontalBaseViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        [self addSubview:_indexLabel];
        [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [_indexLabel sizeToFit];
    }
}

@end
