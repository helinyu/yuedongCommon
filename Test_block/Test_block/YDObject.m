//
//  YDObject.m
//  Test_block
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDObject.h"


@interface YDObject ()

@property (nonatomic, copy) NSString *content;

@end

@implementation YDObject


- (NSString *)wholeNameWithName:(NSString *)name requestHandler:(NSString *(^)(void))requestHandler {
    return [NSString stringWithFormat:@"%@:%@",name,requestHandler()];
}

- (NSString *(^)(NSString *middleName))wholeNameWithLastName:(NSString *)lastName requestHandler:(NSString *(^)(void))requestHandler {
    
    return ^(NSString *middleName) {
        NSString *wholeName = [NSString stringWithFormat:@"familyName: %@ : middleName : %@, lastName:%@",requestHandler(),middleName,lastName];
        return wholeName;
    };
}

- (YDObject *(^)(NSString *name))linkName {
    return ^(NSString *name) {
        return self;
    };
}

- (NSString *)linkName:(NSString *)name {
    return name;
}

- (YDObject *(^)(NSString *name))link2Name:(NSString *)familyName{
   return ^(NSString *name) {
        return self;
    };
}

- (NSString *)linkNone {
    return @"haha";
}

- (YDObject *)linkNoneR {
    return self;
}

- (YDObject *)linkOneParam:(NSString *)lastName {
    NSLog(@"last Name；%@",lastName);
    return self;
}

- (NSString *(^)(NSString *name))block1 {
    return ^(NSString *name) {
        return name;
    };
}

@end
