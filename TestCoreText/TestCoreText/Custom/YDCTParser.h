//
//  YDCTParser.h
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YDCTConfig;
@class YDCTModel;

@interface YDCTParser : NSObject

+ (NSMutableDictionary *)attributesWithConfig:(YDCTConfig *)config;

+ (YDCTModel *)parseAttributedContent:(NSAttributedString *)content config:(YDCTConfig*)config;
+ (YDCTModel *)parseTemplateFile:(NSString *)path
                          config:(YDCTConfig*)config;
@end
