//
//  YDObject.m
//  Test_block
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDObject.h"

@implementation YDObject


- (NSString *)wholeNameWithName:(NSString *)name requestHandler:(NSString *(^)(void))requestHandler {
    return [NSString stringWithFormat:@"%@:%@",name,requestHandler()];
}

@end
