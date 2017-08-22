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

/*
 * 能够链式响应的原因： 
 * （1）没有参数的方法可以用 . 来进行访问
 *  (2)之所以可以link2Name(@"name") 是因为这个是调用染回里面的block，并且block是没有方法名的作为参数，直接就调用了，这个时候就可以执行block，
 * （3）通过2上的block的执行，就反悔了block中的对象
 */

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

//// 错误写法
//- (YDObject *(^blockName)(NSString *name))linkToName {
//    return ^blockName(NSString *name) {
//        NSLog(@"name : %@",name);
//        return self;
//    };
//}

@end
