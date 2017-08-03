//
//  HLYWeightAndFatModel.m
//  test
//
//  Created by felix on 2017/5/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYWeightAndFatModel.h"
#import <UIKit/UIKit.h>

@interface HLYWeightAndFatModel ()


@property (nonatomic, copy) NSString *tilteText;
@property (nonatomic, strong) UIColor *WeightColor;
@property (nonatomic, copy) NSString *weightText;
@property (nonatomic, strong) UIColor *fatPercentColor;
@property (nonatomic, copy) NSString *fatPercentText;
@property (nonatomic, copy) NSString *moreBtnText;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation HLYWeightAndFatModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tilteText = @"一周体重数据";
        self.WeightColor = [UIColor greenColor];
        self.weightText = @"55.4kg";
        self.fatPercentColor = [UIColor yellowColor];
        self.fatPercentText = @"21.8%";
        self.moreBtnText = @"更多";
    }
    return self;
}

@end
