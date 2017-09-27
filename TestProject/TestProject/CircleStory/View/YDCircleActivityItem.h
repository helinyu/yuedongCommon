//
//  YDCircleActivityItem.h
//  SportsBar
//
//  Created by 颜志浩 on 17/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDActivityModel;

@interface YDCircleActivityItem : UICollectionViewCell
@property (nonatomic,   copy) void(^action)();

- (void)setModel:(YDActivityModel *)model;
@end
