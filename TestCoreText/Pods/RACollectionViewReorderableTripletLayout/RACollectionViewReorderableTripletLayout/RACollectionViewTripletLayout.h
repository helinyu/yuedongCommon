//
//  RACollectionViewTripletLayout.h
//  RACollectionViewTripletLayout-Demo
//
//  Created by Ryo Aoyama on 5/25/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RACollectionViewTripletLayoutStyleSquare CGSizeZero

// 布局上面的方法
@protocol RACollectionViewDelegateTripletLayout <UICollectionViewDelegateFlowLayout>

@optional

//（大小）
- (CGSize)collectionView:(UICollectionView *)collectionView sizeForLargeItemsInSection:(NSInteger)section; //Default to automaticaly grow square !

// 内边距
- (UIEdgeInsets)insetsForCollectionView:(UICollectionView *)collectionView;

// seciton的空间大小
- (CGFloat)sectionSpacingForCollectionView:(UICollectionView *)collectionView;

//两个cell之间的
- (CGFloat)minimumInteritemSpacingForCollectionView:(UICollectionView *)collectionView;
// 两行之间
- (CGFloat)minimumLineSpacingForCollectionView:(UICollectionView *)collectionView;
// 大小（大的大小）  内边距
@end

//source 是完全没有变化
@protocol RACollectionViewTripletLayoutDatasource <UICollectionViewDataSource>

@end

@interface RACollectionViewTripletLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<RACollectionViewDelegateTripletLayout> delegate;
@property (nonatomic, weak) id<RACollectionViewTripletLayoutDatasource> datasource;
@property (nonatomic, assign, readonly) CGSize largeCellSize;
@property (nonatomic, assign, readonly) CGSize smallCellSize;

// 内容的高度
- (CGFloat)contentHeight;

@end
