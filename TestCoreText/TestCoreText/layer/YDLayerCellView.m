//
//  YDLayerCellView.m
//  TestCoreText
//
//  Created by mac on 22/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDLayerCellView.h"

@interface YDLayerCellView ()

@property (nonatomic, strong) NSMutableDictionary *mIdentifiers;
@property (nonatomic, strong) NSMutableDictionary *mCellCategories;
@property (nonatomic, strong) NSMutableDictionary *mCells;

@property (nonatomic, assign) NSInteger maxCellNum;


@property (nonatomic, assign) NSInteger beginIndex;

@end

@implementation YDLayerCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self dataInit];
    }
    return self;
}

- (void)dataInit {
    _mIdentifiers = @{}.mutableCopy;
    _mCellCategories = @{}.mutableCopy;
    _mCells = @{}.mutableCopy;
}

- (void)setLayerCellDelegate:(id<YDLayerCellViewDelegate>)layerCellDelegate {
    self.delegate = layerCellDelegate;
    _layerCellDelegate = layerCellDelegate;
}

// 基本的注册
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    NSString *objId = [_mIdentifiers objectForKey:identifier];
    if (objId.length <=0) {
        [_mIdentifiers setObject:identifier forKey:identifier];
        [_mCellCategories setObject:cellClass forKey:identifier];
    }else {
        Class cls = [_mCells objectForKey:identifier];
        if (!cls) {
            [_mCellCategories setObject:cellClass forKey:identifier];
        }
    }
}

- (YDLayerCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
 
    NSString *objId = [_mIdentifiers objectForKey:identifier];
    NSAssert(objId.length >0, @"please use this method , registerClass:forCellReuseIdentifier: to register");
   
    Class cellCategories = [_mCellCategories objectForKey:identifier];
    NSAssert(cellCategories, @"please use this method , registerClass:forCellReuseIdentifier: to register");
 
    YDLayerCell *layerCell = [_mCells objectForKey:identifier];
    if (!layerCell) {
        layerCell = [YDLayerCell new];
    }
  
    NSAssert([self.layerCellDelegate respondsToSelector:@selector(numberOfCell)], @"please implent this method 'numberOfCell' of the delegate ");
    NSInteger numberOfCell = [self.layerCellDelegate numberOfCell];
    
    NSAssert([self.layerCellDelegate respondsToSelector:@selector(widthOfLayerCell)], @"please implent this method 'widthOfLayerCell' of the delegate ");
    CGFloat cellWidth = [self.layerCellDelegate widthOfLayerCell];
    CGFloat cellHeight = self.bounds.size.height;
    self.contentSize = CGSizeMake(cellWidth *numberOfCell, self.bounds.size.height);
    _maxCellNum = self.contentSize.width /cellWidth;
    layerCell.frame = CGRectMake(_beginIndex *cellWidth, 0, cellWidth, cellHeight);
    _beginIndex +=1;
    if (![layerCell.superlayer isEqual:self.layer]) {
        [self.layer addSublayer:layerCell];
    }
    
    [layerCell prepareForReuse];
    
    return layerCell;
}

- (void)reloadData {
    NSLog(@"重新加载");
    NSAssert([self.layerCellDelegate respondsToSelector:@selector(layerCellView:indexPath:)], @"please implent this method 'layerCellView:indexPath:' of the delegate");
    
    NSAssert([self.layerCellDelegate respondsToSelector:@selector(numberOfCell)], @"please implent this method 'numberOfCell' of the delegate ");
    NSInteger numberOfCell = [self.layerCellDelegate numberOfCell];
    
    NSAssert([self.layerCellDelegate respondsToSelector:@selector(widthOfLayerCell)], @"please implent this method 'widthOfLayerCell' of the delegate ");
    CGFloat cellWidth = [self.layerCellDelegate widthOfLayerCell];
    self.contentSize = CGSizeMake(cellWidth *numberOfCell, self.bounds.size.height);
    _maxCellNum = self.contentSize.width /cellWidth;
    
    while (_beginIndex < _maxCellNum) {
        [self.layerCellDelegate layerCellView:self indexPath:[NSIndexPath indexPathForItem:_beginIndex inSection:0]];
    }
    [self layoutIfNeeded];
}

// uiresponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"touchesBegan");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"touchesMoved");
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"touchesEnded");
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"touchesCancelled");
}


@end
