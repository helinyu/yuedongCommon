//
//  YDObject.h
//  Test_block
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDObject : NSObject

@property (nonatomic, copy) NSString *(^blockName)(NSString *middleName);

- (NSString *)wholeNameWithName:(NSString *)name requestHandler:(NSString *(^)(void))requestHandler;

- (NSString *(^)(NSString *middleName))wholeNameWithLastName:(NSString *)lastName requestHandler:(NSString *(^)(void))requestHandler;

- (YDObject *(^)(NSString *name))linkName;
- (YDObject *(^)(NSString *name))link2Name:(NSString *)familyName;
- (NSString *)linkNone;
- (NSString *)linkName:(NSString *)name;
- (YDObject *)linkNoneR;
- (YDObject *)linkOneParam:(NSString *)lastName;
- (NSString *(^)(NSString *name))block1;

@property (nonatomic, copy) NSString *content;


@end
