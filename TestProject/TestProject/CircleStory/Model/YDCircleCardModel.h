//
//  YDCircleRootModel.h
//  SportsBar
//
//  Created by 颜志浩 on 17/3/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YDCircleBannerInfo.h"
#import "YDUserCirclesModel.h"
#import "YDHotTopicModel.h"
#import "YDHotTopicsModelInfo.h"
#import "YDHotActivitiesModel.h"
#import "YDActivityModel.h"
#import "YDOriginCircleModel.h"
#import "YDCircleThemeModel.h"
#import "YDAd.h"

@class YDCircleBannerInfo;
@class YDCircleBannerModel;
@class YDUserCirclesModel;
@class YDOriginCircleModel;
@class YDHotActivitiesModel;
@class YDActivityModel;
@class YDCircleThemeModel;
@class YDHotTopicModel;
@class YDTopicRecommendInfo;
@class YDAd;

typedef NS_ENUM(NSInteger, YDCircleCardModelType) {
    YDCircleCardModelTypeBanner,
    YDCircleCardModelTypeCircle,
    YDCircleCardModelTypeLive,
    YDCircleCardModelTypeActivity,
    YDCircleCardModelTypeChoiceness,
    YDCircleCardModelTypeTopic,
    YDCircleCardModelTypeRecommend,
    YDCircleCardModelTypeAd,
};

@interface YDCircleCardModel : NSObject

@property (nonatomic, assign) YDCircleCardModelType type;

@property (nonatomic, strong) YDCircleBannerInfo *bannerInfo;

@property (nonatomic, strong) YDUserCirclesModel *circlesModel;
@property (nonatomic, strong) YDOriginCircleModel *circleModel;

@property (nonatomic, strong) YDAd *ad;

@property (nonatomic, strong) NSMutableArray<NSString *> *liveImagesArr;
@property (nonatomic,   copy) NSString *liveImageString;


@property (nonatomic, strong) YDHotActivitiesModel *activitiesModel;
@property (nonatomic, strong) YDActivityModel *activity;


@property (nonatomic, strong) YDCircleThemeModel *themeModel;

//@property (nonatomic, strong) YDHotTopicsModelInfo *topicsInfo;
@property (nonatomic, strong) YDHotTopicModel *topicModel;
@property (nonatomic, strong) NSArray<YDTopicRecommendInfo *> *recommendInfos;
@property (nonatomic,   copy) NSString *recomAction;
@property (nonatomic, assign, getter=getItemSize) CGSize itemSize;


@property (nonatomic, assign) NSInteger insertIndex;





@end
