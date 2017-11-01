//
//  YDImgZoomCCell.h
//  SportsBar
//
//  Created by Aka on 2017/10/30.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDImgZoomCCell : UICollectionViewCell

@property (nonatomic, strong) UIScrollView *zoomView;
@property (nonatomic, strong) UIView *imgBgview;
@property (nonatomic, strong) UIImageView *imgView;

- (void)baseInit;

@end
