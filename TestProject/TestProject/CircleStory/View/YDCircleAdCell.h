//
//  YDCircleAdCell.h
//  SportsBar
//
//  Created by 张旻可 on 29/03/2017.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDAd;

@interface YDCircleAdCell : UICollectionViewCell

@property (nonatomic, strong, readonly) YDAd *model;

+ (YDCircleAdCell *)reusableCellForCollectionView:(UICollectionView *)collectionView cellId:(NSString *)cell_id indexPath:(NSIndexPath *)index_path model:(YDAd *)model;

@end
