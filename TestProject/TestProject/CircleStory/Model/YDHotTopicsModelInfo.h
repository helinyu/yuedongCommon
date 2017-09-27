//
//  YDHotTopicsModelInfo.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"


@class YDHotTopicModel;
@class YDTopicRecommendInfo;
@interface YDHotTopicsModelInfo : NSObject<MSJsonSerializing>

@property (nonatomic,   copy) NSString *allHotArticlesUrl;
@property (nonatomic, strong) NSArray<YDHotTopicModel *> *articles;
@property (nonatomic, assign) NSInteger hasMore;
@property (nonatomic,   copy) NSString *recomAction;
@property (nonatomic, strong) NSNumber *position;
@property (nonatomic, strong) NSArray<YDTopicRecommendInfo *> *recommendInfos;


@end

