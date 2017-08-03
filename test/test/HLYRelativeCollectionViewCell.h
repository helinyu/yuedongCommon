//
//  HLYRelativeCell.h
//  test
//
//  Created by felix on 2017/6/6.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLYRelativeCellModel;

@interface HLYRelativeCollectionViewCell : UICollectionViewCell

+ (HLYRelativeCollectionViewCell *)reuseCollectionVeiw:(UICollectionView *)collectionView withIdentifier:(NSString *) identifier indexPath:(NSIndexPath *)indexPath model:(HLYRelativeCellModel *)model;

@end

@interface HLYRelativeCellModel : NSObject

+ (HLYRelativeCellModel *)configureTitle:(NSString *)titleText numText:(NSString *)numText updateNumText:(NSString *)updateNumText;


@end
