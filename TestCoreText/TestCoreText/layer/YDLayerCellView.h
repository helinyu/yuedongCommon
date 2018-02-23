//
//  YDLayerCellView.h
//  TestCoreText
//
//  Created by mac on 22/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDLayerCell.h"
@class YDLayerCellView;

@protocol YDLayerCellViewDelegate <UIScrollViewDelegate>

@optional
- (NSInteger)numberOfCell;
- (CGFloat)widthOfLayerCell;
- (YDLayerCell *)layerCellView:(YDLayerCellView *)layerCellView indexPath:(NSIndexPath *)indexPath;

@end

@interface YDLayerCellView : UIScrollView

@property (nonatomic, weak) id<YDLayerCellViewDelegate> layerCellDelegate;

- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (YDLayerCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)reloadData;

@end
