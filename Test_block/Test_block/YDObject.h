//
//  YDObject.h
//  Test_block
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDObject : NSObject

- (NSString *)wholeNameWithName:(NSString *)name requestHandler:(NSString *(^)(void))requestHandler;

@end
