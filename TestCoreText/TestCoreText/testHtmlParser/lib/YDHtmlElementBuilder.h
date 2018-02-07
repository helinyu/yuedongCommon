//
//  YDHtmlElementBuilder.h
//  TestCoreText
//
//  Created by mac on 7/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDHtmlParser.h"

@interface YDHtmlElementBuilder : NSObject

/**
 init the element builder

 @param data html element data
 @param encoding string coding
 @return return self
 */
- (YDHtmlElementBuilder *)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding;

@end
