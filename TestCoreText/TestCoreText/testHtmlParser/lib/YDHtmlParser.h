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

//@optional
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
- (void)yd_startElement:(YDHtmlParser *)parser atts:(NSDictionary *)attsDic;
- (void)yd_endElement:(YDHtmlParser *)parser name:(NSString *)name;
- (void)yd_reference:(YDHtmlParser *)parser name:(NSString *)name;
- (void)yd_characters:(YDHtmlParser *)parser character:(NSString *)character length:(int)length;
- (void)yd_ignorableWhitespace:(YDHtmlParser *)parser character:(NSString *)chString length:(int)length;

- (void)yd_processingInstruction:(YDHtmlParser *)parser target:(NSString *)target data:(NSString *)dataStr;
- (void)yd_comment:(YDHtmlParser *)parser valueString:(NSString *)valueStr;
- (void)yd_warning:(YDHtmlParser *)parser msg:(NSString *)msg;
- (void)yd_error:(YDHtmlParser *)parser;
- (void)yd_fatalError:(YDHtmlParser *)parser;
- (void)yd_cdataBlock:(YDHtmlParser *)parser cdataString:(NSString *)cdataSting length:(NSInteger)length;
- (void)yd_externalSubset:(YDHtmlParser *)parser name:(NSString *)name externalId:(NSString *)externalId systemId:(NSString *)systemId;
- (void)yd_startElementNs:(YDHtmlParser *)parser;
- (void)yd_endElementNs:(YDHtmlParser *)parser;
- (void)yd_serror:(YDHtmlParser *)parser;

@end

@interface YDHtmlParser : NSObject

@property (nonatomic, weak) id<YDHtmlParserDelegate> delegate;

// && properties
@property (nonatomic, readonly) htmlSAXHandler xmlHandler;
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


/**
 parsing html methods now

 @return flag
 */
- (BOOL)parsing;

@end
