//
//  YDParserNode.h
//  TestCoreText
//
//  Created by mac on 8/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDHtmlParserNode : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<YDHtmlParserNode *> *childNodes;

@property (nonatomic, strong) YDHtmlParserNode *parentNode;

@property (nonatomic, copy) NSString *context;

@property (nonatomic, copy) NSDictionary *attributes;

- (BOOL)addChildNode:(YDHtmlParserNode *)childNode;
- (BOOL)addChildNodes:(NSArray<YDHtmlParserNode *> *)childNode;

- (BOOL)removeChildNode:(YDHtmlParserNode *)childNode;
- (BOOL)removeChildNodes:(NSArray<YDHtmlParserNode *> *)childNodes;
- (BOOL)removeAllChildNodes;

@end
