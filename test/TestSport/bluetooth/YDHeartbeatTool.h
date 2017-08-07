//
//  YDHeartbeatTool.h
//  SportsBar
//
//  Created by 卓名杰 on 10/11/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDHeartbeatTool : NSObject

@property(nonatomic,assign)BOOL isBraceletDayUpload;

+(YDHeartbeatTool *)shareHeartbeatTool;

-(void)uploadBraceletDayDataWithCompletion:(void (^)(void))completion;

@end
