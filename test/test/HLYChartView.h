//
//  HLYTableView.h
//  test
//
//  Created by felix on 2017/5/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLYChartViewModel;

@interface HLYChartView : UIView

@property (nonatomic, strong, readonly) HLYChartViewModel *model;

- (void)ms_load;

@property (nonatomic, copy) void(^act_tap)(NSInteger viewTag);


@end

@interface HLYChartViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray<NSString *> *bottomLabelNames;
@property (nonatomic, strong, readonly) NSArray<NSNumber *> *leftSideStandardDatas; // 侧栏的标准数
@property (nonatomic, strong, readonly) NSArray<NSNumber *> *upDatas; // 体重量
@property (nonatomic, strong, readonly) NSArray<NSNumber *> *downDatas; // 脂肪的量

@property (nonatomic, assign, readonly) CGFloat upMaxData;
@property (nonatomic, assign, readonly) CGFloat downMaxData;

@property (nonatomic, assign, readonly) CGSize size;

@property (nonatomic, strong, readonly) UIColor *upCurrentColor;
@property (nonatomic, strong, readonly) UIColor *downCurrentColor;
@property (nonatomic, strong, readonly) UIColor *upNomalColor;
@property (nonatomic, strong, readonly) UIColor *downNomalColor;
@property (nonatomic, assign, readonly) NSInteger currentIndex;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (void)initChartViewSize:(CGSize)size;
- (void)configureBottomLabelNamess:(NSArray<NSString *> *)labelNames upDatas:(NSArray<NSNumber *> *)upDatas downDatas:(NSArray<NSNumber *> *)downDatas;

@end

FOUNDATION_EXPORT NSInteger const viewTagBaseConstant;
