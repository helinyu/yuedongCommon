//
//  YDHorizontalTableView.m
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHorizontalTableView.h"
#import "YDHorizontalBaseViewCell.h"
#import "YDLayerCell.h"
#import "YDHorizontalRowDetail.h"

@interface YDHorizontalTableView ()

@property (nonatomic, strong) NSMapTable *cellIdentifiers;
@property (nonatomic, strong) NSMutableArray *rowRecords;
@property (nonatomic, strong) NSMutableIndexSet *visibleRows;
@property (nonatomic, strong) NSMutableDictionary *visibleCells;

@property (nonatomic, strong) NSMutableDictionary *cellPool;

@property (nonatomic, strong) Class currentCls;

@end

@implementation YDHorizontalTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    _cellIdentifiers = [NSMapTable new];
    _cellPool = @{}.mutableCopy;
    _rowRecords = @[].mutableCopy;
    _visibleRows = [NSMutableIndexSet new];
    _visibleCells = @{}.mutableCopy;
    self.bounces = NO;
    self.alwaysBounceHorizontal = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"gh- layout subViews");
    
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    if (_rowRecords.count >0) {
        [self layoutTableView];
    }
}

- (void)layoutTableView {
    CGFloat startX = self.contentOffset.x;
    CGFloat endX = self.contentOffset.x + self.bounds.size.width;
    NSRange willShowRange = [self rangeOfWillShowWithStartX:startX endX:endX];
    for (NSUInteger i = willShowRange.location; i < willShowRange.location + willShowRange.length; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if (_cellType ==YDHorizontalTableViewCelltypeLayer) {
            YDLayerCell *cell = [self.visibleCells objectForKey:@(i)];
            if (!cell) {
                cell = (YDLayerCell *)[self.dataSource horizontalLayerTableView:self cellForRowAtIndexPath:indexPath];
                if (cell) {
                    [_visibleCells setObject:cell forKey:@(i)];
                }
                YDHorizontalRowDetail *detail = self.rowRecords[i];
                cell.frame = CGRectMake(detail.startX, 0.f, detail.rowWidth, self.frame.size.height);
                [self.layer addSublayer:cell];
            }
        }
        else {
            YDHorizontalBaseViewCell *cell = [self.visibleCells objectForKey:@(i)];
            if (!cell) {
                cell = [self.dataSource horizontalTableView:self cellForRowAtIndexPath:indexPath];
                if (cell) {
                    [_visibleCells setObject:cell forKey:@(i)];
                }
                YDHorizontalRowDetail *detail = self.rowRecords[i];
                cell.frame = CGRectMake(detail.startX, 0.f, detail.rowWidth, self.frame.size.height);
                [self addSubview:cell];
            }
        }
    }
    
    NSArray *allVisibleCells = [self.visibleCells allKeys];
    for (NSNumber *numb in allVisibleCells) {
        if (!NSLocationInRange([numb integerValue], willShowRange)) {
            if (_cellType == YDHorizontalTableViewCelltypeLayer) {
                YDLayerCell *cell = [self.visibleCells objectForKey:numb];
                [_cellPool setObject:cell forKey:@(cell.cellIndex)];
                [_visibleCells removeObjectForKey:numb];
                [cell removeFromSuperlayer];
            }
            else {
                YDHorizontalBaseViewCell *cell = [self.visibleCells objectForKey:numb];
                [_cellPool setObject:cell forKey:@(cell.cellIndex)];
                [_visibleCells removeObjectForKey:numb];
                [cell removeFromSuperview];
            }
        }
    }
}

- (NSRange)rangeOfWillShowWithStartX:(CGFloat)startX endX:(CGFloat)endX {
    YDHorizontalRowDetail *startDetail = [YDHorizontalRowDetail new];
    startDetail.startX = startX;
    YDHorizontalRowDetail *endDetail = [YDHorizontalRowDetail new];
    endDetail.startX = endX;
    
    NSInteger startIndex = [_rowRecords indexOfObject:startDetail inSortedRange:NSMakeRange(0, _rowRecords.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(YDHorizontalRowDetail * obj1, YDHorizontalRowDetail * obj2) {
        if (obj1.startX < obj2.startX) return NSOrderedAscending;
        return NSOrderedDescending;
    }];
    if (startIndex > 0) startIndex--;
    
    NSInteger endIndex = [_rowRecords indexOfObject:endDetail inSortedRange:NSMakeRange(0, _rowRecords.count - 1) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(YDHorizontalRowDetail * obj1, YDHorizontalRowDetail * obj2) {
        if (obj1.startX < obj2.startX) return NSOrderedAscending;
        return NSOrderedDescending;
    }];
//    if (endIndex > 0) endIndex--;
    return NSMakeRange(startIndex, endIndex - startIndex + 1);
}

- (void)reloadData {
    [self countPosition];
}

- (void)countPosition {
    CGFloat startX = self.contentOffset.x;
    CGFloat totalWidth = startX;
    if ([self.dataSource respondsToSelector:@selector(numberOfRows)]) {
        NSInteger rowCount = [self.dataSource numberOfRows];
        for (int i = 0; i < rowCount; i++) {
            CGFloat width = 44;
            if ([self.dataSource respondsToSelector:@selector(widthOfRow)]) {
                width = [self.dataSource widthOfRow];
            }
            totalWidth += width;
            YDHorizontalRowDetail *rowDetail = [YDHorizontalRowDetail new];
            rowDetail.startX = startX;
            rowDetail.rowWidth = width;
            startX = startX + width;
            [self.rowRecords addObject:rowDetail];
        }
    }
    self.contentSize = CGSizeMake(ceilf(totalWidth), self.frame.size.height);
}

- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    if (_cellIdentifiers.count >0) {
        id cell = [_cellIdentifiers objectForKey:identifier];
        if (cell) return;
    }
     [_cellIdentifiers setObject:cellClass forKey:identifier];
}

- (YDHorizontalBaseViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    NSAssert(identifier.length >0, @"please asset that the identifier length must larger then 0");
    Class cls = [_cellIdentifiers objectForKey:identifier];
    NSAssert(cls, @"must register the cell");
    
    YDHorizontalBaseViewCell *cell;
    if (_cellPool.count >0) {
        YDHorizontalBaseViewCell *cell = [_cellPool objectForKey:@(indexPath.row)];
        if (!cell) {
            NSArray *allKeys = _cellPool.allKeys;
            cell = [_cellPool objectForKey:allKeys.firstObject];
            [_cellPool removeObjectForKey:allKeys.firstObject];
        }
        else {
            cell = [YDHorizontalBaseViewCell new];
        }
    }
    else {
        cell = [YDHorizontalBaseViewCell new];
    }
    cell.cellIndex = indexPath.row;
    return cell;
}

- (YDLayerCell *)dequeueReusableLayerCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    NSAssert(identifier.length >0, @"please asset that the identifier length must larger then 0");
    Class cls = [_cellIdentifiers objectForKey:identifier];
    NSAssert(cls, @"must register the cell");
    
    YDLayerCell *cell;
    if (_cellPool.count >0) {
        YDLayerCell *cell = [_cellPool objectForKey:@(indexPath.row)];
        if (!cell) {
            NSArray *allKeys = _cellPool.allKeys;
            cell = [_cellPool objectForKey:allKeys.firstObject];
            [_cellPool removeObjectForKey:allKeys.firstObject];
        }
        else {
            cell = [YDLayerCell new];
            CGFloat cellWidth = [self.dataSource widthOfRow];
            cell.frame = CGRectMake(0, indexPath.row *cellWidth, cellWidth, self.bounds.size.height);
        }
    }
    else {
        cell = [YDLayerCell new];
        CGFloat cellWidth = [self.dataSource widthOfRow];
        cell.frame = CGRectMake(0, indexPath.row *cellWidth, cellWidth, self.bounds.size.height);
    }
    cell.cellIndex = indexPath.row;
    return cell;
}


@end
