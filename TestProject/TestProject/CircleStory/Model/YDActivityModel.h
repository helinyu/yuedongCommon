//
//  YDActivityModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@interface YDActivityModel : NSObject<MSJsonSerializing>

@property (nonatomic,   copy) NSString *action;
@property (nonatomic, assign) NSInteger circleId;
@property (nonatomic,   copy) NSString *desc;
@property (nonatomic,   copy) NSString *kDescription;
@property (nonatomic, assign) NSInteger groupRunId;
@property (nonatomic,   copy) NSString *icon;
@property (nonatomic, assign) NSInteger kindId;
@property (nonatomic,   copy) NSString *title;
@property (nonatomic,   copy) NSString *iconNew;

@end
