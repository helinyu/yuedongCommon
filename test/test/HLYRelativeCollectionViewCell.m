//
//  HLYRelativeCell.m
//  test
//
//  Created by felix on 2017/6/6.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYRelativeCollectionViewCell.h"
#import "Masonry.h"


@interface HLYRelativeCollectionViewCell()

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *updateLabel;
@property (nonatomic, strong) HLYRelativeCellModel *model;

@end

@implementation HLYRelativeCollectionViewCell

+ (HLYRelativeCollectionViewCell *)reuseCollectionVeiw:(UICollectionView *)collectionView withIdentifier:(NSString *) identifier indexPath:(NSIndexPath *)indexPath model:(HLYRelativeCellModel *)model {
    
    HLYRelativeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HLYRelativeCollectionViewCell class]) forIndexPath:indexPath];
    [cell configure:model];
    return cell;
}

- (void)configure:(HLYRelativeCellModel *)model {
    if (!_model) {
        _model = [HLYRelativeCellModel new];
        _model = model;
    }
    
    [self comInit];
    [self styleInit];
}

- (void)comInit {
    _numLabel = [UILabel new];
    [self.contentView addSubview:_numLabel];
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_numLabel];
    
    _updateLabel = [UILabel new];
    [self.contentView addSubview:_updateLabel];
    
    [self createConstraints];
}

- (void)createConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(self);
    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self.mas_bottom);
    }];
    
    [_updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(_titleLabel.mas_centerY);
    }];
}

- (void)styleInit {
    _updateLabel.backgroundColor = [UIColor redColor];
}

@end

@interface HLYRelativeCellModel()

@property (nonatomic, strong) NSString *numText;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *updateNumText;

@end

@implementation HLYRelativeCellModel

+ (HLYRelativeCellModel *)configureTitle:(NSString *)titleText numText:(NSString *)numText updateNumText:(NSString *)updateNumText {
    HLYRelativeCellModel *model = [HLYRelativeCellModel new];
    model.numText = numText;
    model.titleText = titleText;
    model.updateNumText = updateNumText;
    return model;
}

@end
