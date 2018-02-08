//
//  YDHtmlParser.m
//  TestCoreText
//
//  Created by mac on 7/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHtmlParser.h"
//#import <libxml/HTMLtree.h>


#pragma mark -- header properties

@interface YDHtmlParser () <NSXMLParserDelegate>
//{
//    xmlSAXHandler _htmlHandler;
//
//}

@property (nonatomic) htmlSAXHandler htmlHandler;
@property (nonatomic) htmlParserCtxtPtr parserContext;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NSStringEncoding encoding;

@end

@implementation YDHtmlParser

#pragma mark -- parser callback

void yd_internalSubsetHandler(void *ctx, const xmlChar *name, const xmlChar *ExternalID, const xmlChar *SystemID) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_internalSubset:blockSelf];
}

//int *yd_isStandalonehtmlHandler (void *ctx) {
//    NSLog(@"yd_isStandalonehtmlHandler ctx :%@",ctx);
//    return (int*)ctx;
//}
//
//int *yd_hasInternalSubsethtmlHandler(void *ctx) {
//    NSLog(@"ctx :%@",ctx);
//    return (int*)ctx;
//}
//
//int *yd_hasExternalSubsethtmlHandler(void *ctx) {
//    NSLog(@"yd_hasExternalSubsethtmlHandler");
//    return (int *)ctx;
//}

// 重新处理输入的内容
//xmlParserInputPtr yd_resolveEntityhtmlHandler(void *ctx, const xmlChar *publicId, const xmlChar *systemId) {
//    NSLog(@"yd_resolveEntityhtmlHandler");
//    return
//}

void yd_entityDeclhtmlHandler(void *ctx, const xmlChar *name, int type, const xmlChar *publicId, const xmlChar *systemId, xmlChar *content) {
    NSLog(@"yd_entityDeclSAXFuncHandler ctx:%@ , name:%s, type:%zd, publicdId :%s, systemId:%s, content:%s",ctx, name, type, publicId, systemId, content);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_entityDecl:blockSelf];
}

void yd_notationDeclHanlder(void *ctx, const xmlChar *name, const xmlChar *publicId, const xmlChar *systemId) {
    NSLog(@"yd_notationDeclHanlder ctx:%@, name:%s , publicId:%s, systemId;%s",ctx, name, publicId, systemId);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_notationDecl:blockSelf];
}


void yd_attributeDeclhtmlHandler(void *ctx,
                             const xmlChar *elem,
                             const xmlChar *fullname,
                             int type,
                             int def,
                             const xmlChar *defaultValue,
                             xmlEnumerationPtr tree) {
    NSLog(@"yd_attributeDeclHandler ctx:%@ , elem:%s, fullname:%s type:%zd, def:%zd, defautlValue:%zd, tree:%@",ctx, elem, fullname, type, def, defaultValue, tree);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_attributeDecl:blockSelf];
}

void yd_elementDeclhtmlHandler(void *ctx,
                           const xmlChar *name,
                           int type,
                               xmlElementContentPtr content) {
    NSLog(@"yd_elementDeclhtmlHandler ctx:%@, name:%s, type:%zd, content:%@",ctx,name, type, content);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_elementDecl:blockSelf];
}

void yd_unparsedEntityDeclhtmlHandler(void *ctx,
                                  const xmlChar *name,
                                  const xmlChar *publicId,
                                  const xmlChar *systemId,
                                     const xmlChar *notationName) {
    NSLog(@"yd_unparsedEntityDeclhtmlHandler ctx:%@, name:%s, publicId:%s, systemId:%s, notationName:%s",ctx, name, publicId, systemId, notationName);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_unparsedEntityDecl:blockSelf];
}

void yd_setDocumentLocatorhtmlHandler (void *ctx,
                                   xmlSAXLocatorPtr loc) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
//    loc->getPublicId =
//    xmlChar *ptr = loc->(*getPublicId)(ctx);
    // 这里应该定义一个函数指针进行计算对应的内容（block）
//    xmlChar *systemId = loc->getSystemId(ctx); //外面定义一个方法处理
    int lineNumber = loc->getLineNumber(ctx);
    int columnNumber = loc->getColumnNumber(ctx);
    [blockSelf.delegate yd_setDocumentLocator:blockSelf];
}

void yd_startDocumenthtmlHandler (void *ctx) {
    NSLog(@"yd_startDocumenthtmlHandler ctx:%@",ctx);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_startDocument:blockSelf];
}

void yd_endDocumenthtmlHandler(void *ctx) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_endDocument:blockSelf];
}

void yd_startElementhtmlHandler (void *ctx,
                             const xmlChar *name,
                                const xmlChar **atts)  {
    NSMutableDictionary *attsDic;
    if (atts)
    {
        NSString *key = nil;
        NSString *value = nil;
        attsDic = @{}.mutableCopy;
        int i = 0;// 属性获取 （二维数组）
        while (1)
        {
            char *att = (char *)atts[i++];
            if (!key) {
                if (!att) {
                    break; // 解析完成
                }
                key = [NSString stringWithUTF8String:att];
            }
            else {
                @autoreleasepool { // 这个释放池可能没有作用
                    if (att) {
                        value = [NSString stringWithUTF8String:att];
                    }
                    else {
                        value = key;
                    }
                }
                [attsDic setObject:value forKey:key];
                value = nil;
                key = nil;
            }
        }
    }
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_startElement:blockSelf atts:attsDic];
}

void yd_endElementhtmlHandler (void *ctx, const xmlChar *name) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *nameStr = [NSString stringWithUTF8String:(const char *)name];
    [blockSelf.delegate yd_endElement:blockSelf name:nameStr];
}

void yd_referencehtmlHandler (void *ctx, const xmlChar *name) {
    NSLog(@"yd_referencehtmlHandler ctx:%@, name:%s",ctx, name);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *nameStr = [NSString stringWithUTF8String:(char *)name];
    [blockSelf.delegate yd_reference:blockSelf name:nameStr];
}

void yd_charactershtmlHandler (void *ctx,
                           const xmlChar *ch,
                           int len) {
    NSLog(@"yd_charactershtmlHandler ctx:%@, ch: %s, length:%zd", ctx, ch, len);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *chStr = [NSString stringWithUTF8String:(char *)ch];
    [blockSelf.delegate yd_characters:blockSelf character:chStr length:len];
}

void yd_ignorableWhitespacehtmlHandler (void *ctx,
                                    const xmlChar *ch,
                                       int len) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *chString = [NSString stringWithUTF8String:(char *)ch];
    [blockSelf.delegate yd_ignorableWhitespace:blockSelf character:chString length:len];
}

void yd_processingInstructionhtmlHandler (void *ctx,
                                           const xmlChar *target,
                                      const xmlChar *data) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *targetStr = [NSString stringWithUTF8String:(char *)target];
    NSString *dataStr = [NSString stringWithUTF8String:(char *)data];
    [blockSelf.delegate yd_processingInstruction:blockSelf target:targetStr data:dataStr];
}

void yd_commenthtmlHandler (void *ctx, const xmlChar *value) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *valueStr = [NSString stringWithUTF8String:(const char*)value];
    [blockSelf.delegate yd_comment:blockSelf valueString:valueStr];
}

void yd_warninghtmlHandler(void *ctx, const char *msg, ...) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *msgStr = [NSString stringWithUTF8String:(char *)msg];
    [blockSelf.delegate yd_warning:blockSelf msg:msgStr];
}

void yd_errorhtmlHandler (void *ctx, const char *msg, ...) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_error:blockSelf];
}

void yd_fatalErrorhtmlHandler (void *ctx, const char *msg, ...) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_fatalError:blockSelf];
}

void yd_cdataBlockHandler (void *ctx,
                           const xmlChar *value,
                           int len) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *cdataString = [NSString stringWithUTF8String:(const char *)value];
    [blockSelf.delegate yd_cdataBlock:blockSelf cdataString:cdataString length:len];
}

void yd_externalSubsethtmlHandler (void *ctx,
                               const xmlChar *name,
                               const xmlChar *ExternalID,
                               const xmlChar *SystemID) {
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    NSString *nameStr = [NSString stringWithUTF8String:(char *)name];
    NSString *externalIDStr = [NSString stringWithUTF8String:(char *)ExternalID];
    NSString *systemIDStr = [NSString stringWithUTF8String:(char *)SystemID];
    [blockSelf.delegate yd_externalSubset:blockSelf name:nameStr externalId:externalIDStr systemId:systemIDStr];
}

// 这个视乎还没有执行到
void yd_startElementNshtmlHandler (void *ctx,
                                const xmlChar *localname,
                                const xmlChar *prefix,
                                const xmlChar *URI,
                                int nb_namespaces,
                                const xmlChar **namespaces,
                                int nb_attributes,
                                int nb_defaulted,
                               const xmlChar **attributes) {
    NSLog(@"yd_startElementNshtmlHandler ctx:%@, localName:%s, prefix:%s, URi:%s, nb_namespace:%zd, namespace:%p, nb_attributes:%zd, nb_defaulted:%zd, attriburtes:%p",ctx, localname, prefix, URI, nb_namespaces, namespaces, nb_attributes, nb_defaulted,attributes);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_startElementNs:blockSelf];
}

void yd_endElementNshtmlHandler (void *ctx,
                                     const xmlChar *localname,
                                     const xmlChar *prefix,
                                     const xmlChar *URI) {
    NSLog(@"yd_endElementNshtmlHandler ctx:%@, localName:%s, prefix:%s, URI:%s",ctx,localname, prefix, URI);
    YDHtmlParser *blockSelf = (__bridge YDHtmlParser *)ctx;
    [blockSelf.delegate yd_endElementNs:blockSelf];
}

void yd_serrorhtmlHandler(void *userData, xmlErrorPtr error) {
    NSLog(@"yd_serrorhtmlHandler userData:%@, error:%@",userData, error);
}

#pragma mark -- set delegate

- (void)setDelegate:(id<YDHtmlParserDelegate>)delegate {
    _delegate = delegate;
    
    if ([delegate respondsToSelector:@selector(yd_internalSubset:)]) {
        _htmlHandler.internalSubset = yd_internalSubsetHandler;
    }
    else {
        _htmlHandler.internalSubset = NULL;
    }
    
//    if ([delegate respondsToSelector:@selector(yd_isStandalone:)]) {
//        _htmlHandler.isStandalone = yd_isStandalonehtmlHandler;
//    }
//    else {
//        _htmlHandler.isStandalone = NULL;
//    }
//
//    if ([delegate respondsToSelector:@selector(yd_hasInternalSubset:)]) {
//        _htmlHandler.hasInternalSubset = yd_hasInternalSubsethtmlHandler;
//    }
//    else {
//        _htmlHandler.hasInternalSubset = NULL;
//    }
//
//    if ([delegate respondsToSelector:@selector(yd_hasExternalSubset:)]) {
//        _htmlHandler.hasExternalSubset = yd_hasExternalSubsethtmlHandler;
//    }
//    else {
//        _htmlHandler.hasExternalSubset = NULL;
//    }
//
//    if ([delegate respondsToSelector:@selector(yd_resolveEntity:)]) {
//        _htmlHandler.resolveEntity = yd_resolveEntityhtmlHandler;
//    }
//    else {
//        _htmlHandler.resolveEntity  = NULL;
//    }
//
//    if ([delegate respondsToSelector:@selector(yd_getEntity:)]) {
//        _htmlHandler.getEntity = yd_getEntityhtmlHandler;
//    }
//    else {
//        _htmlHandler.getEntity = NULL:
//    }
    
    if ([delegate respondsToSelector:@selector(yd_entityDecl:)]) {
        _htmlHandler.entityDecl = yd_entityDeclhtmlHandler;
    }
    else {
        _htmlHandler.entityDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_notationDecl:)]) {
        _htmlHandler.notationDecl = yd_notationDeclHanlder;
    }
    else {
        _htmlHandler.notationDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_attributeDecl:)]) {
        _htmlHandler.attributeDecl = yd_attributeDeclhtmlHandler;
    }
    else {
        _htmlHandler.attributeDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_elementDecl:)]) {
        _htmlHandler.elementDecl = yd_elementDeclhtmlHandler;
    }
    else {
        _htmlHandler.elementDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_unparsedEntityDecl:)]) {
        _htmlHandler.unparsedEntityDecl = yd_unparsedEntityDeclhtmlHandler;
    }
    else {
        _htmlHandler.unparsedEntityDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_setDocumentLocator:)]) {
        _htmlHandler.setDocumentLocator = yd_setDocumentLocatorhtmlHandler;
    }
    else {
        _htmlHandler.setDocumentLocator = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_startDocument:)]) {
        _htmlHandler.startDocument = yd_startDocumenthtmlHandler;
    }
    else {
        _htmlHandler.startDocument = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_endDocument:)]) {
        _htmlHandler.endDocument = yd_endDocumenthtmlHandler;
    }
    else {
        _htmlHandler.endDocument = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_startElement:atts:)]) {
        _htmlHandler.startElement = yd_startElementhtmlHandler;
    }
    else {
        _htmlHandler.startElement = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_endElement:name:)]) {
        _htmlHandler.endElement = yd_endElementhtmlHandler;
    }
    else {
        _htmlHandler.endElement = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_reference:name:)]) {
        _htmlHandler.reference = yd_referencehtmlHandler;
    }
    else {
        _htmlHandler.reference = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_characters:character:length:)]) {
        _htmlHandler.characters = yd_charactershtmlHandler;
    }
    else {
        _htmlHandler.characters = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_ignorableWhitespace:character:length:)]) {
        _htmlHandler.ignorableWhitespace = yd_ignorableWhitespacehtmlHandler;
    }
    else {
        _htmlHandler.ignorableWhitespace = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_processingInstruction:target:data:)]) {
        _htmlHandler.processingInstruction = yd_processingInstructionhtmlHandler;
    }
    else {
        _htmlHandler.processingInstruction = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_comment:valueString:)]) {
        _htmlHandler.comment = yd_commenthtmlHandler;
    }
    else {
        _htmlHandler.comment = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_warning:msg:)]) {
        _htmlHandler.warning = yd_warninghtmlHandler;
    }
    else {
        _htmlHandler.warning = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_error:)]) {
        _htmlHandler.error = yd_errorhtmlHandler;
    }
    else {
        _htmlHandler.error = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_fatalError:)]) {
        _htmlHandler.fatalError = yd_fatalErrorhtmlHandler;
    }
    else {
        _htmlHandler.fatalError = NULL;
    }
    
//    if ([delegate respondsToSelector:@selector(yd_getParameterEntity:)]) {
//        _htmlHandler.getParameterEntity = yd_getParameterEntityhtmlHandler;
//    }
//    else {
//        _htmlHandler.getParameterEntity = NULL;
//    }
    
    if ([delegate respondsToSelector:@selector(yd_cdataBlock:cdataString:length:)]) {
        _htmlHandler.cdataBlock = yd_cdataBlockHandler;
    }
    else {
        _htmlHandler.cdataBlock = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_externalSubset:name:externalId:systemId:)]) {
        _htmlHandler.externalSubset = yd_externalSubsethtmlHandler;
    }
    else {
        _htmlHandler.externalSubset = NULL;
    }
    
//    if ([delegate respondsToSelector:yd_initialized:]) {
//        _htmlHandler.initialized = yd_initializedhtmlHandler;
//    }
//    else {
//        _htmlHandler.initialized = NULL;
//    }
    
//    if ([delegate respondsToSelector:@selector(yd__private:)]) {
//        _htmlHandler._private = yd__privatehtmlHandler;
//    }
//    else {
//        _htmlHandler._private = NULL;
//    }
    
    if ([delegate respondsToSelector:@selector(yd_startElementNs:)]) {
        _htmlHandler.startElementNs = yd_startElementNshtmlHandler;
    }
    else {
        _htmlHandler.startElementNs = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_endElementNs:)]) {
        _htmlHandler.endElementNs = yd_endElementNshtmlHandler;
    }
    else {
        _htmlHandler.endElementNs = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_serror:)]) {
        _htmlHandler.serror = yd_serrorhtmlHandler;
    }
    else {
        _htmlHandler.serror = NULL;
    }
}

#pragma mark -- base methods

// init 这个方法只能够在init开头的方法里面调用
- (id)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding
{
    if (!data)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _data = data;
        _encoding = encoding;
        xmlSAX2InitHtmlDefaultSAXHandler(&_htmlHandler);
        self.delegate = nil; // 设置默认处理（没有处理）否则将会崩溃,否则存在野指针
    }
    return self;
}

#pragma mark custom methods

- (BOOL)parsing
{
    void *dataBytes = (char *)[_data bytes];
    unsigned long dataSize = [_data length];
    
    // detect encoding if necessary
    xmlCharEncoding charEnc = XML_CHAR_ENCODING_NONE;
    
    if (!_encoding)
    {
        charEnc = xmlDetectCharEncoding(dataBytes, (int)dataSize);
    }
    else
    {
        // convert the encoding
        CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(_encoding);
        
        if (cfenc != kCFStringEncodingInvalidId)
        {
            CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
            
            if (cfencstr)
            {
                NSString *NS_VALID_UNTIL_END_OF_SCOPE encstr = [NSString stringWithString:(__bridge NSString*)cfencstr];
                const char *enc = [encstr UTF8String];
                
                charEnc = xmlParseCharEncoding(enc);
            }
        }
    }
    
    // create a parse context
    _parserContext = htmlCreatePushParserCtxt(&_htmlHandler, (__bridge void *)self, dataBytes, (int)dataSize, NULL, charEnc);
    
    // set some options
    htmlCtxtUseOptions(_parserContext, HTML_PARSE_RECOVER | HTML_PARSE_NONET | HTML_PARSE_COMPACT | HTML_PARSE_NOBLANKS);
    
    // parse!
    int result = htmlParseDocument(_parserContext);
    
    return (result==0);
}

@end
