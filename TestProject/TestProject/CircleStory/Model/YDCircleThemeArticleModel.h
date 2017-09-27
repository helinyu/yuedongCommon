//
//  YDCircleThemeArticleModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/12/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@class YDOriginCircleModel;
@interface YDCircleThemeArticleModel : NSObject<MSJsonSerializing>

@property (nonatomic,   copy) NSString *action;
@property (nonatomic, strong) NSNumber *articleDiscussCnt;
@property (nonatomic,   copy) NSString *articleIconUrl;
@property (nonatomic, strong) NSNumber *articleId;
@property (nonatomic, strong) NSNumber *likeCnt;
@property (nonatomic, strong) NSNumber *likeFlag;
@property (nonatomic,   copy) NSString *articleTitle;
@property (nonatomic, strong) YDOriginCircleModel *circle;


@end
