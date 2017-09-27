//
//  YDCircleBannerModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"


@interface YDCircleBannerModel : NSObject<MSJsonSerializing>

@property (nonatomic,   copy) NSString *action;
@property (nonatomic,   copy) NSString *adIdentify;
@property (nonatomic,   copy) NSString *image;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic,   copy) NSString *statName;
@property (nonatomic,   copy) NSString *redirectUrl;
@property (nonatomic,   copy) NSString *param;


@end
