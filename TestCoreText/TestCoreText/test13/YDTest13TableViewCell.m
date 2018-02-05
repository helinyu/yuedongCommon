//
//  YDTest13TableViewCell.m
//  TestCoreText
//
//  Created by mac on 5/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest13TableViewCell.h"
#import "Masonry.h"

@implementation YDTest13TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {

    if (!_titleLabel) {
        _titleLabel = [UILabel new];
       [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.contentView);
        }];
    }
    
    if (!_msLabel) {
        _msLabel = [UILabel new];
        [self addSubview:_msLabel];
        [_msLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(200);
        }];
    }
}

-  (void)prepareForReuse {
    [super prepareForReuse];
    _titleLabel.text = nil;
    _msLabel.text = nil;
}

@end
