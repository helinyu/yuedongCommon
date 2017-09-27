//
//  YDHotActivitiesModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@class YDActivityModel;
@interface YDHotActivitiesModel : NSObject<MSJsonSerializing>

@property (nonatomic, strong) NSArray<YDActivityModel *> *activities;
@property (nonatomic,   copy) NSString *allActivityJumpAction;

/**
 *  设置动画标示
 */
@property (nonatomic, assign) BOOL hasDisplayed;
@end
