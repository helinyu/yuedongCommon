//
//  HLYTopCell.m
//  test
//
//  Created by felix on 2017/6/6.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYTopTableViewCell.h"
#import "HLYCollectionViewCell.h"

@interface HLYTopTableViewCell()

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *levelImageView;
@property (nonatomic, strong) UIImageView *vipImageView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UICollectionView *relativeCollectionView;

@property (nonatomic, strong) HLYTopTableViewCellModel *model;

@end

@implementation HLYTopTableViewCell


+ (HLYTopTableViewCell *)reuseCell:(UITableView *)tableView indentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath model:(HLYTopTableViewCellModel *)model {
    HLYTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell configureModel:model];
    return cell;
}

- (void)configureModel:(HLYTopTableViewCellModel *)model {
   
    if (_model == nil) {
        _model = model;
    }
    
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(93, 18, 100, 30);
        [self.contentView addSubview:_titleLabel];
    }
    
    if (_descriptionLabel == nil) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.frame = CGRectMake(93, 50, 100, 25);
        [self.contentView addSubview:_descriptionLabel];
    }
    
    _titleLabel.text = _model.titleText;
    _descriptionLabel.text = model.descriptionText;

//    CollectionView
    if (_relativeCollectionView == nil) {
        _relativeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        [self.contentView addSubview:_relativeCollectionView];
        _relativeCollectionView.backgroundColor = [UIColor yellowColor];
    }
    
}

@end


@interface HLYTopTableViewCellModel ()

@end

@implementation HLYTopTableViewCellModel


@end
