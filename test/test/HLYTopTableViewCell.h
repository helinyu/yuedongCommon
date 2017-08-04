//
//  HLYTopCell.h
//  test
//
//  Created by felix on 2017/6/6.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLYTopTableViewCellModel;

@interface HLYTopTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UICollectionView *relativeCollectionView;


- (void)configureModel:(HLYTopTableViewCellModel *)model;

+ (HLYTopTableViewCell *)reuseCell:(UITableView *)tableView indentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath model:(HLYTopTableViewCellModel *)model;

@end

@interface HLYTopTableViewCellModel : NSObject

@property (nonatomic, copy) NSString *avatarText;
@property (nonatomic, copy) NSString *levelText;
@property (nonatomic, copy) NSString *updateText;
@property (nonatomic, strong) NSArray *relatives;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *descriptionText;


@end
