//
//  YDCircleThemeArticleInfos.h
//  SportsBar
//
//  Created by 颜志浩 on 16/12/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@class YDCircleThemeArticleModel;
@interface YDCircleThemeArticleInfos : NSObject<MSJsonSerializing>
@property (nonatomic,   copy) NSString *allHotArticlesJumpAction;
@property (nonatomic, strong) NSNumber *hasMore;
@property (nonatomic, strong) NSArray<YDCircleThemeArticleModel *> *infos;

@end
