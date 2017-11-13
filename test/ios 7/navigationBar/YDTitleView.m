//
//  YDTitleView.m
//  ios 7
//
//  Created by Aka on 2017/11/13.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDTitleView.h"
#import "Masonry.h"

@implementation YDTitleView

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
    [self addSubview:_titleLabel];
    
    _imgView = [UIImageView new];
    [self addSubview:_imgView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.superview);
        make.centerY.equalTo(_titleLabel.superview);
        make.width.mas_equalTo(60);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imgView.superview);
        make.centerY.equalTo(_imgView.superview);
        make.width.height.mas_equalTo(40.f);
    }];
    
    _titleLabel.text = @"标题";
    _imgView.image = [UIImage imageNamed:@"Snip20171113_1.png"];
}

@end
