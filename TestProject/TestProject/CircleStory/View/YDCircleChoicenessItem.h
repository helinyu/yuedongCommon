//
//  YDCircleChoicenessItem.h
//  SportsBar
//
//  Created by 颜志浩 on 17/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDCircleThemeModel;

@interface YDCircleChoicenessItem : UICollectionViewCell

@property (nonatomic,   copy) void(^action)();

- (void)setThemeInfo:(YDCircleThemeModel *)theme;
@end
