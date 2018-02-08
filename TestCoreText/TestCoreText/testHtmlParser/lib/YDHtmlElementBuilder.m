//
//  YDHtmlElementBuilder.m
//  TestCoreText
//
//  Created by mac on 7/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHtmlElementBuilder.h"

@interface YDHtmlElementBuilder ()<YDHtmlParserDelegate>
{
    dispatch_queue_t _parserQueue;
}

@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NSStringEncoding encoding;

@property (nonatomic, strong) NSMutableAttributedString *tmpString;

@property (nonatomic, strong) YDHtmlParser *parser;



@end

@implementation YDHtmlElementBuilder

- (YDHtmlElementBuilder *)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding {
    self = [super init];
    if (self) {
        _tmpString = [NSMutableAttributedString new];
        _data = data;
        _encoding = encoding;
        _parser = [[YDHtmlParser alloc] initWithData:data encoding:encoding];
        _parser.delegate = self;
        [self _queueInit];
        BOOL flag = [_parser parsing];
        NSLog(@"parsing ;%zd",flag);
    }
    return self;
}

#pragma mark -- queue
- (void)_queueInit {
    _parserQueue = dispatch_queue_create("YD.HTML.DISPATCH.QUEUE", 0);
}

#pragma mark -- ydparser delegate

- (void)yd_internalSubset:(YDHtmlParser *)parser {
    NSLog(@"yd_internalSubset");
}

- (void)yd_isStandalone:(YDHtmlParser *)parser {
    NSLog(@"yd_isStandalone");
}

- (void)yd_hasInternalSubset:(YDHtmlParser *)parser {
    NSLog(@"yd_hasInternalSubset");
}

- (void)yd_entityDecl:(YDHtmlParser *)parser {
    NSLog(@"yd_entityDecl");
}

- (void)yd_notationDecl:(YDHtmlParser *)parser {
    NSLog(@"yd_notationDecl");
}

- (void)yd_attributeDecl:(YDHtmlParser *)parser {
    NSLog(@"yd_attributeDecl");
}

- (void)yd_elementDecl:(YDHtmlParser *)parser {
    NSLog(@"yd_elementDecl");
}

- (void)yd_unparsedEntityDecl:(YDHtmlParser *)parser {
    NSLog(@"yd_unparsedEntityDecl");
}

- (void)yd_setDocumentLocator:(YDHtmlParser *)parser {
    NSLog(@"yd_setDocumentLocator");
}

- (void)yd_startDocument:(YDHtmlParser *)parser {
    NSLog(@"yd_startDocument");
}
- (void)yd_endDocument:(YDHtmlParser *)parser {
    NSLog(@"yd_endDocument");
}
- (void)yd_startElement:(YDHtmlParser *)parser atts:(NSDictionary *)attsDic {
    NSLog(@"yd_startElement");
}
- (void)yd_endElement:(YDHtmlParser *)parser name:(NSString *)name {
    NSLog(@"yd_endElement");
}
- (void)yd_reference:(YDHtmlParser *)parser name:(NSString *)name {
    NSLog(@"yd_reference");
}
- (void)yd_characters:(YDHtmlParser *)parser character:(NSString *)character length:(int)length {
    NSLog(@"yd_characters");
}
- (void)yd_ignorableWhitespace:(YDHtmlParser *)parser character:(NSString *)chString length:(int)length {
    NSLog(@"yd_ignorableWhitespace");
}
- (void)yd_processingInstruction:(YDHtmlParser *)parser target:(NSString *)target data:(NSString *)dataStr {
    NSLog(@"yd_processingInstruction");
}
- (void)yd_comment:(YDHtmlParser *)parser valueString:(NSString *)valueStr {
    NSLog(@"yd_comment");
}
- (void)yd_warning:(YDHtmlParser *)parser msg:(NSString *)msg {
    NSLog(@"yd_warning");
}
- (void)yd_error:(YDHtmlParser *)parser {
    NSLog(@"yd_error");
}
- (void)yd_fatalError:(YDHtmlParser *)parser {
    NSLog(@"yd_fatalError");
}
- (void)yd_cdataBlock:(YDHtmlParser *)parser cdataString:(NSString *)cdataSting length:(NSInteger)length {
    NSLog(@"yd_cdataBlock");
}
- (void)yd_externalSubset:(YDHtmlParser *)parser name:(NSString *)name externalId:(NSString *)externalId systemId:(NSString *)systemId {
    NSLog(@"yd_externalSubset");
}
- (void)yd_startElementNs:(YDHtmlParser *)parser  {
    NSLog(@"yd_startElementNs");
}
- (void)yd_endElementNs:(YDHtmlParser *)parser {
    NSLog(@"yd_endElementNs");
}
- (void)yd_serror:(YDHtmlParser *)parser {
    NSLog(@"yd_serror");
}

@end
