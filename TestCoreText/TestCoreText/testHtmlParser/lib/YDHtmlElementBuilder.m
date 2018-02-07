//
//  YDHtmlElementBuilder.m
//  TestCoreText
//
//  Created by mac on 7/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHtmlElementBuilder.h"

@interface YDHtmlElementBuilder ()

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) YDHtmlParser *parser;

@end

@implementation YDHtmlElementBuilder

- (YDHtmlElementBuilder *)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding {
    self = [super init];
    if (self) {
        _data = data;
        _parser = [[YDHtmlParser alloc] initWithData:data encoding:encoding] ;
    }
    return self;
}

@end
