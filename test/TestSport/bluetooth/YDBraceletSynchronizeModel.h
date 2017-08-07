//
//  YDBraceletSynchronizeModel.h
//  DoStyle
//
//  Created by zmj on 14-9-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDBraceletSynchronizeModel : NSObject
@property (nonatomic,copy)NSNumber *userID;
@property (nonatomic,copy)NSNumber *syncID;
@property (nonatomic,copy)NSNumber *pointNum;
@property (nonatomic,copy)NSNumber *endTime;
@property (nonatomic,copy)NSNumber *beginTime;
@property (nonatomic,copy)NSString *pointDetail;

@property (nonatomic,copy)NSNumber *dayNum;
@property (nonatomic,copy)NSNumber *beginNum;
@property (nonatomic,copy)NSNumber *endNum;
@property (nonatomic,copy)NSString *peripheralUUID;

#pragma mark--未计入数据库参数
@property (nonatomic,retain)NSMutableArray *pointArray;
@property (nonatomic,assign)BOOL isSave;

@end
