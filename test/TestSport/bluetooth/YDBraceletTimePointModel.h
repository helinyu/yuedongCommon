//
//  YDBraceletTimePointModel.h
//  DoStyle
//
//  Created by zmj on 14-9-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDBraceletTimePointModel : NSObject
@property (nonatomic,copy)NSNumber *seq;
@property (nonatomic,copy)NSNumber *step;
@property (nonatomic,copy)NSNumber *calorie;
@property (nonatomic,copy)NSNumber *distance;
@property (nonatomic,copy)NSNumber *sleep;
@property (nonatomic,copy)NSNumber *syncID;

-(id)initWithDic:(NSDictionary *)dic;
@end
