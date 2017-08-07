//
//  YDBleCycleBuffer.h
//  DoStyle
//
//  Created by caojikui on 14-9-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YDBleCycleBuffer : NSObject

@property (nonatomic,copy)NSNumber *capacity;
@property (nonatomic,copy)NSNumber *startPos;
@property (nonatomic,copy)NSNumber *endPos;

+(id)sharedInstance;
-(BOOL) put:(NSData *)data;

-(NSData *) getUnit;

@end
