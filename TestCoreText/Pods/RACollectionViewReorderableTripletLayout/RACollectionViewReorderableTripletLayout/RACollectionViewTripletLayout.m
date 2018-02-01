//
//  RACollectionViewTripletLayout.m
//  RACollectionViewTripletLayout-Demo
//
//  Created by Ryo Aoyama on 5/25/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import "RACollectionViewTripletLayout.h"

@interface RACollectionViewTripletLayout()

@property (nonatomic, assign) NSInteger numberOfCells;
@property (nonatomic, assign) CGFloat numberOfLines;
@property (nonatomic, assign) CGFloat sectionSpacing;
@property (nonatomic, assign) CGSize collectionViewSize;
@property (nonatomic, assign) CGRect oldRect;
//@property (nonatomic, strong) NSArray *oldArray;
@property (nonatomic, strong) NSMutableArray *largeCellSizeArray;
@property (nonatomic, strong) NSMutableArray *smallCellSizeArray;

@end

@implementation RACollectionViewTripletLayout

#pragma mark - Over ride flow layout methods

- (void)prepareLayout
{
    [super prepareLayout];
    
    _collectionViewSize = self.collectionView.bounds.size;
    _sectionSpacing = 0;
//    基本的结构
    
    if ([self.delegate respondsToSelector:@selector(minimumInteritemSpacingForCollectionView:)]) {
        self.minimumInteritemSpacing = [self.delegate minimumInteritemSpacingForCollectionView:self.collectionView];
    }
    
    if ([self.delegate respondsToSelector:@selector(minimumLineSpacingForCollectionView:)]) {
        self.minimumLineSpacing = [self.delegate minimumLineSpacingForCollectionView:self.collectionView];
    }
    
    if ([self.delegate respondsToSelector:@selector(sectionSpacingForCollectionView:)]) {
        _sectionSpacing = [self.delegate sectionSpacingForCollectionView:self.collectionView];
    }
    
    if ([self.delegate respondsToSelector:@selector(insetsForCollectionView:)]) {
        self.sectionInset = [self.delegate insetsForCollectionView:self.collectionView];
    }
}

- (CGFloat)contentHeight
{
    CGFloat contentHeight = 0;
    NSInteger numberOfSections = self.collectionView.numberOfSections;
    CGSize collectionViewSize = self.collectionView.bounds.size;
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if ([self.delegate respondsToSelector:@selector(insetsForCollectionView:)]) {
        insets = [self.delegate insetsForCollectionView:self.collectionView];
    }
    CGFloat sectionSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(sectionSpacingForCollectionView:)]) {
        sectionSpacing = [self.delegate sectionSpacingForCollectionView:self.collectionView];
    }
    CGFloat itemSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(minimumInteritemSpacingForCollectionView:)]) {
        itemSpacing = [self.delegate minimumInteritemSpacingForCollectionView:self.collectionView];
    }
    CGFloat lineSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(minimumLineSpacingForCollectionView:)]) {
       lineSpacing = [self.delegate minimumLineSpacingForCollectionView:self.collectionView];
    }
    
    contentHeight += insets.top + insets.bottom + sectionSpacing * (numberOfSections - 1);
//    先加入空隙的高度
// sectionSpacing * (numberOfSections - 1) 这个只是多个距离之间大小
    
    CGFloat lastSmallCellHeight = 0;
    for (NSInteger i = 0; i < numberOfSections; i++) {
        NSInteger numberOfLines = ceil((CGFloat)[self.collectionView numberOfItemsInSection:i] / 3.f);
//         计算出函数（向上取整）
        
        CGFloat largeCellSideLength = (2.f * (collectionViewSize.width - insets.left - insets.right) - itemSpacing) / 3.f;
        CGFloat smallCellSideLength = (largeCellSideLength - itemSpacing) / 2.f;
//        大的边 是小边的两倍
        
        CGSize largeCellSize = CGSizeMake(largeCellSideLength, largeCellSideLength);
        CGSize smallCellSize = CGSizeMake(smallCellSideLength, smallCellSideLength);
        
        if ([self.delegate respondsToSelector:@selector(collectionView:sizeForLargeItemsInSection:)]) {
            if (!CGSizeEqualToSize([self.delegate collectionView:self.collectionView sizeForLargeItemsInSection:i], RACollectionViewTripletLayoutStyleSquare)) {
                largeCellSize = [self.delegate collectionView:self.collectionView sizeForLargeItemsInSection:i];
                smallCellSize = CGSizeMake(collectionViewSize.width - largeCellSize.width - itemSpacing - insets.left - insets.right, (largeCellSize.height- itemSpacing)/ 2.f);
            }
        }
        lastSmallCellHeight = smallCellSize.height;
        CGFloat largeCellHeight = largeCellSize.height;
        
        CGFloat lineHeight = numberOfLines * (largeCellHeight + lineSpacing) - lineSpacing;
        contentHeight += lineHeight;
    }
    
    NSInteger numberOfItemsInLastSection = [self.collectionView numberOfItemsInSection:numberOfSections -1];
    if ((numberOfItemsInLastSection - 1) % 3 == 0 && (numberOfItemsInLastSection - 1) % 6 != 0) {
        contentHeight -= lastSmallCellHeight + itemSpacing;
    }
    
    return contentHeight;
}

- (void)setDelegate:(id<RACollectionViewDelegateTripletLayout>)delegate
{
    self.collectionView.delegate = delegate;
}
// delegate传递，注意这样的写法很常见

- (id<RACollectionViewDelegateTripletLayout>)delegate
{
    return (id<RACollectionViewDelegateTripletLayout>)self.collectionView.delegate;
}

- (CGSize)collectionViewContentSize
{
//    CGSize contentSize = CGSizeMake(_collectionViewSize.width, 0);
//    for (NSInteger i = 0; i < self.collectionView.numberOfSections; i++) {
//        if ([self.collectionView numberOfItemsInSection:i] == 0) {
//            break;
//        }
//        NSInteger numberOfLines = ceil((CGFloat)[self.collectionView numberOfItemsInSection:i] / 3.f);
//        CGFloat lineHeight = numberOfLines * ([_largeCellSizeArray[i] CGSizeValue].height + self.minimumLineSpacing) - self.minimumLineSpacing;
//        contentSize.height += lineHeight;
//    }
//    contentSize.height += self.sectionInset.top + self.sectionInset.bottom + _sectionSpacing * (self.collectionView.numberOfSections - 1);
//    NSInteger numberOfItemsInLastSection = [self.collectionView numberOfItemsInSection:self.collectionView.numberOfSections - 1];
//    if ((numberOfItemsInLastSection - 1) % 3 == 0 && (numberOfItemsInLastSection - 1) % 6 != 0) {
//        contentSize.height -= [_smallCellSizeArray[self.collectionView.numberOfSections - 1] CGSizeValue].height + self.minimumInteritemSpacing;
//    }
    return CGSizeMake(_collectionViewSize.width, self.contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    _oldRect = rect;
    NSMutableArray *attributesArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.collectionView.numberOfSections; i++) {
        NSInteger numberOfCellsInSection = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < numberOfCellsInSection; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [attributesArray addObject:attributes];
            }
        }
    }
    return  attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];\
//    这里主要是填充attribute的属性；

    //cellSize
    CGFloat largeCellSideLength = (2.f * (_collectionViewSize.width - self.sectionInset.left - self.sectionInset.right) - self.minimumInteritemSpacing) / 3.f;
    CGFloat smallCellSideLength = (largeCellSideLength - self.minimumInteritemSpacing) / 2.f;
    _largeCellSize = CGSizeMake(largeCellSideLength, largeCellSideLength);
    _smallCellSize = CGSizeMake(smallCellSideLength, smallCellSideLength);
    if ([self.delegate respondsToSelector:@selector(collectionView:sizeForLargeItemsInSection:)]) {
        if (!CGSizeEqualToSize([self.delegate collectionView:self.collectionView sizeForLargeItemsInSection:indexPath.section], RACollectionViewTripletLayoutStyleSquare)) {
            _largeCellSize = [self.delegate collectionView:self.collectionView sizeForLargeItemsInSection:indexPath.section];
            _smallCellSize = CGSizeMake(_collectionViewSize.width - _largeCellSize.width - self.minimumInteritemSpacing - self.sectionInset.left - self.sectionInset.right, (_largeCellSize.height / 2.f) - (self.minimumInteritemSpacing / 2.f));
        }
    }
    if (!_largeCellSizeArray) {
        _largeCellSizeArray = [NSMutableArray array];
    }
    if (!_smallCellSizeArray) {
        _smallCellSizeArray = [NSMutableArray array];
    }
    _largeCellSizeArray[indexPath.section] = [NSValue valueWithCGSize:_largeCellSize];
    _smallCellSizeArray[indexPath.section] = [NSValue valueWithCGSize:_smallCellSize];
    
    //section height
    CGFloat sectionHeight = 0;
    for (NSInteger i = 0; i <= indexPath.section - 1; i++) {
        NSInteger cellsCount = [self.collectionView numberOfItemsInSection:i];
        CGFloat largeCellHeight = [_largeCellSizeArray[i] CGSizeValue].height;
        CGFloat smallCellHeight = [_smallCellSizeArray[i] CGSizeValue].height;
        NSInteger lines = ceil((CGFloat)cellsCount / 3.f);
        sectionHeight += lines * (self.minimumLineSpacing + largeCellHeight) + _sectionSpacing;
        if ((cellsCount - 1) % 3 == 0 && (cellsCount - 1) % 6 != 0) {
            sectionHeight -= smallCellHeight + self.minimumInteritemSpacing;
        }
    }
    if (sectionHeight > 0) {
        sectionHeight -= self.minimumLineSpacing;
    }

    NSInteger line = indexPath.item / 3;
    CGFloat lineSpaceForIndexPath = self.minimumLineSpacing * line;
    CGFloat lineOriginY = _largeCellSize.height * line + sectionHeight + lineSpaceForIndexPath + self.sectionInset.top;
    CGFloat rightSideLargeCellOriginX = _collectionViewSize.width - _largeCellSize.width - self.sectionInset.right;
    CGFloat rightSideSmallCellOriginX = _collectionViewSize.width - _smallCellSize.width - self.sectionInset.right;
    
    if (indexPath.item % 6 == 0) {
        attribute.frame = CGRectMake(self.sectionInset.left, lineOriginY, _largeCellSize.width, _largeCellSize.height);
    }else if ((indexPath.item + 1) % 6 == 0) {
        attribute.frame = CGRectMake(rightSideLargeCellOriginX, lineOriginY, _largeCellSize.width, _largeCellSize.height);
    }else if (line % 2 == 0) {
        if (indexPath.item % 2 != 0) {
            attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY, _smallCellSize.width, _smallCellSize.height);
        }else {
            attribute.frame =CGRectMake(rightSideSmallCellOriginX, lineOriginY + _smallCellSize.height + self.minimumInteritemSpacing, _smallCellSize.width, _smallCellSize.height);
        }
    }else {
        if (indexPath.item % 2 != 0) {
            attribute.frame = CGRectMake(self.sectionInset.left, lineOriginY, _smallCellSize.width, _smallCellSize.height);
        }else {
            attribute.frame =CGRectMake(self.sectionInset.left, lineOriginY + _smallCellSize.height + self.minimumInteritemSpacing, _smallCellSize.width, _smallCellSize.height);
        }
    }
    return attribute;// 主要是设置frame
}

//- (UIUserInterfaceLayoutDirection)developmentLayoutDirection {
//    return UIUserInterfaceLayoutDirectionRightToLeft;
//}
//
//- (BOOL)flipsHorizontallyInOppositeLayoutDirection {
//    return YES;
//}

@end
