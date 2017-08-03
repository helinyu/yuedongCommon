//
//  HLYOnlinePictureCCell.h
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLYBackdropOnlineModel;

@interface HLYOnlinePictureCCell : UICollectionViewCell

+ (HLYOnlinePictureCCell *)reuseCollectionVeiw:(UICollectionView *)collectionView withIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath model:(HLYBackdropOnlineModel *)model;

@end
