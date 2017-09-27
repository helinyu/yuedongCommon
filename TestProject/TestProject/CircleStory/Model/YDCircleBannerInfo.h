//
//  YDCircleBannerInfo.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@class YDCircleBannerModel;
@interface YDCircleBannerInfo : NSObject<MSJsonSerializing>

@property (nonatomic, strong) NSArray<YDCircleBannerModel *> *banners;
@property (nonatomic, assign) CGFloat whRatio;

@end
