//
//  YDHtmlParser.h
//  TestCoreText
//
//  Created by mac on 7/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>
@class YDHtmlParser;

@protocol YDHtmlParserDelegate <NSObject>

// change to block 
- (void)yd_internalSubset:(YDHtmlParser *)parser;
- (void)yd_isStandalone:(YDHtmlParser *)parser;
- (void)yd_hasInternalSubset:(YDHtmlParser *)parser;
- (void)yd_entityDecl:(YDHtmlParser *)parser;
- (void)yd_notationDecl:(YDHtmlParser *)parser;

- (void)yd_attributeDecl:(YDHtmlParser *)parser;
- (void)yd_elementDecl:(YDHtmlParser *)parser;
- (void)yd_unparsedEntityDecl:(YDHtmlParser *)parser;
- (void)yd_setDocumentLocator:(YDHtmlParser *)parser;
- (void)yd_startDocument:(YDHtmlParser *)parser;
- (void)yd_endDocument:(YDHtmlParser *)parser;
- (void)yd_startElement:(YDHtmlParser *)parser;
- (void)yd_endElement:(YDHtmlParser *)parser;
- (void)yd_reference:(YDHtmlParser *)parser;
- (void)yd_characters:(YDHtmlParser *)parser;
- (void)yd_ignorableWhitespace:(YDHtmlParser *)parser;
- (void)yd_processingInstruction:(YDHtmlParser *)parser;
- (void)yd_comment:(YDHtmlParser *)parser;
- (void)yd_warning:(YDHtmlParser *)parser;
- (void)yd_error:(YDHtmlParser *)parser;
- (void)yd_fatalError:(YDHtmlParser *)parser;
- (void)yd_cdataBlock:(YDHtmlParser *)parser;
- (void)yd_externalSubset:(YDHtmlParser *)parser;
- (void)yd_startElementNs:(YDHtmlParser *)parser;
- (void)yd_endElementNs:(YDHtmlParser *)parser;
- (void)yd_serror:(YDHtmlParser *)parser;

@end

@interface YDHtmlParser : NSObject

@property (nonatomic, weak) id<YDHtmlParserDelegate> delegate;

// && properties
@property (nonatomic, readonly) xmlSAXHandler xmlHandler;
@property (nonatomic, strong, readonly) NSData *data;
@property (nonatomic, assign, readonly) NSStringEncoding encoding;

//methods
/**
 init the parser obj with the data & encoding,we must use it to init a obj

 @param data html element datas
 @param encoding encoding (may be utf-8)
 @return return self
 */
- (id)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding;

@end
