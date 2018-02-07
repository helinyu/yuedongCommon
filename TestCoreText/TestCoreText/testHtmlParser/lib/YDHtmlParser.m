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
//    xmlSAXHandler _xmlHandler;
//
//}

@property (nonatomic) xmlSAXHandler xmlHandler;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NSStringEncoding encoding;

@end

@implementation YDHtmlParser

#pragma mark -- parser callback

void yd_internalSubsetHandler(void *ctx, const xmlChar *name, const xmlChar *ExternalID, const xmlChar *SystemID) {
    NSLog(@"gh- internal sub set: ctx:%@, name:%s, externalId:%s, systemId:%s",ctx, name, ExternalID,SystemID);
}

//int *yd_isStandalonexmlHandler (void *ctx) {
//    NSLog(@"yd_isStandalonexmlHandler ctx :%@",ctx);
//    return (int*)ctx;
//}
//
//int *yd_hasInternalSubsetxmlHandler(void *ctx) {
//    NSLog(@"ctx :%@",ctx);
//    return (int*)ctx;
//}
//
//int *yd_hasExternalSubsetxmlHandler(void *ctx) {
//    NSLog(@"yd_hasExternalSubsetxmlHandler");
//    return (int *)ctx;
//}

// 重新处理输入的内容
//xmlParserInputPtr yd_resolveEntityxmlHandler(void *ctx, const xmlChar *publicId, const xmlChar *systemId) {
//    NSLog(@"yd_resolveEntityxmlHandler");
//    return
//}

void yd_entityDeclxmlHandler(void *ctx, const xmlChar *name, int type, const xmlChar *publicId, const xmlChar *systemId, xmlChar *content) {
    NSLog(@"yd_entityDeclSAXFuncHandler");
}

void yd_notationDeclHanlder(void *ctx, const xmlChar *name, const xmlChar *publicId, const xmlChar *systemId) {
    NSLog(@"yd_notationDeclHanlder");
}


void yd_attributeDeclxmlHandler(void *ctx,
                             const xmlChar *elem,
                             const xmlChar *fullname,
                             int type,
                             int def,
                             const xmlChar *defaultValue,
                             xmlEnumerationPtr tree) {
    NSLog(@"yd_attributeDeclHandler");
}

void yd_elementDeclxmlHandler(void *ctx,
                           const xmlChar *name,
                           int type,
                               xmlElementContentPtr content) {
    NSLog(@"yd_elementDeclxmlHandler");
}

void yd_unparsedEntityDeclxmlHandler(void *ctx,
                                  const xmlChar *name,
                                  const xmlChar *publicId,
                                  const xmlChar *systemId,
                                     const xmlChar *notationName) {
    NSLog(@"yd_unparsedEntityDeclxmlHandler");
}

void yd_setDocumentLocatorxmlHandler (void *ctx,
                                   xmlSAXLocatorPtr loc) {
    NSLog(@"yd_setDocumentLocatorHandler");
}

void yd_startDocumentxmlHandler (void *ctx) {
    NSLog(@"yd_startDocumentxmlHandler");
}

void yd_endDocumentxmlHandler(void *ctx) {
    NSLog(@"yd_endDocumentxmlHandler");
}

void yd_startElementxmlHandler (void *ctx,
                             const xmlChar *name,
                                const xmlChar **atts)  {
    NSLog(@"yd_startElementxmlHandler");
}

void yd_endElementxmlHandler (void *ctx, const xmlChar *name) {
    NSLog(@"yd_endElementxmlHandler");
}

void yd_referencexmlHandler (void *ctx, const xmlChar *name) {
    NSLog(@"yd_referencexmlHandler");
}

void yd_charactersxmlHandler (void *ctx,
                           const xmlChar *ch,
                           int len) {
    NSLog(@"yd_charactersxmlHandler");
}

void yd_ignorableWhitespacexmlHandler (void *ctx,
                                    const xmlChar *ch,
                                       int len) {
    NSLog(@"yd_ignorableWhitespacexmlHandler");
}

void yd_processingInstructionxmlHandler (void *ctx,
                                           const xmlChar *target,
                                      const xmlChar *data) {
    NSLog(@"yd_processingInstructionxmlHandler");
}

void yd_commentxmlHandler (void *ctx,
                        const xmlChar *value) {
    NSLog(@"yd_commentxmlHandler");
}

void yd_warningxmlHandler(void *ctx, const char *msg, ...) {
    NSLog(@"yd_warningxmlHandler");
}

void yd_errorxmlHandler (void *ctx,
                               const char *msg, ...) {
    NSLog(@"yd_errorxmlHandler");
}

void yd_fatalErrorxmlHandler (void *ctx, const char *msg, ...) {
    NSLog(@"yd_fatalErrorxmlHandler");
}


void yd_cdataBlockHandler (
                           void *ctx,
                           const xmlChar *value,
                           int len) {
    NSLog(@"yd_cdataBlockHandler");
}

void yd_externalSubsetxmlHandler (void *ctx,
                               const xmlChar *name,
                               const xmlChar *ExternalID,
                               const xmlChar *SystemID) {
    NSLog(@"yd_externalSubsetxmlHandler");
}

void yd_startElementNsxmlHandler (void *ctx,
                                const xmlChar *localname,
                                const xmlChar *prefix,
                                const xmlChar *URI,
                                int nb_namespaces,
                                const xmlChar **namespaces,
                                int nb_attributes,
                                int nb_defaulted,
                               const xmlChar **attributes) {
    NSLog(@"yd_startElementNsxmlHandler");
}

void yd_endElementNsxmlHandler (void *ctx,
                                     const xmlChar *localname,
                                     const xmlChar *prefix,
                                     const xmlChar *URI) {
    NSLog(@"yd_endElementNsxmlHandler");
}

void yd_serrorxmlHandler(void *userData, xmlErrorPtr error) {
    NSLog(@"yd_serrorxmlHandler");
}

#pragma mark -- set delegate

- (void)setDelegate:(id<YDHtmlParserDelegate>)delegate {
    _delegate = delegate;
    
    if ([delegate respondsToSelector:@selector(yd_internalSubset:)]) {
        _xmlHandler.internalSubset = yd_internalSubsetHandler;
    }
    else {
        _xmlHandler.internalSubset = NULL;
    }
    
//    if ([delegate respondsToSelector:@selector(yd_isStandalone:)]) {
//        _xmlHandler.isStandalone = yd_isStandalonexmlHandler;
//    }
//    else {
//        _xmlHandler.isStandalone = NULL;
//    }
//
//    if ([delegate respondsToSelector:@selector(yd_hasInternalSubset:)]) {
//        _xmlHandler.hasInternalSubset = yd_hasInternalSubsetxmlHandler;
//    }
//    else {
//        _xmlHandler.hasInternalSubset = NULL;
//    }
//
//    if ([delegate respondsToSelector:@selector(yd_hasExternalSubset:)]) {
//        _xmlHandler.hasExternalSubset = yd_hasExternalSubsetxmlHandler;
//    }
//    else {
//        _xmlHandler.hasExternalSubset = NULL;
//    }
//
//    if ([delegate respondsToSelector:@selector(yd_resolveEntity:)]) {
//        _xmlHandler.resolveEntity = yd_resolveEntityxmlHandler;
//    }
//    else {
//        _xmlHandler.resolveEntity  = NULL;
//    }
//
//    if ([delegate respondsToSelector:@selector(yd_getEntity:)]) {
//        _xmlHandler.getEntity = yd_getEntityxmlHandler;
//    }
//    else {
//        _xmlHandler.getEntity = NULL:
//    }
    
    if ([delegate respondsToSelector:@selector(yd_entityDecl:)]) {
        _xmlHandler.entityDecl = yd_entityDeclxmlHandler;
    }
    else {
        _xmlHandler.entityDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_notationDecl:)]) {
        _xmlHandler.notationDecl = yd_notationDeclHanlder;
    }
    else {
        _xmlHandler.notationDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_attributeDecl:)]) {
        _xmlHandler.attributeDecl = yd_attributeDeclxmlHandler;
    }
    else {
        _xmlHandler.attributeDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_elementDecl:)]) {
        _xmlHandler.elementDecl = yd_elementDeclxmlHandler;
    }
    else {
        _xmlHandler.elementDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_unparsedEntityDecl:)]) {
        _xmlHandler.unparsedEntityDecl = yd_unparsedEntityDeclxmlHandler;
    }
    else {
        _xmlHandler.unparsedEntityDecl = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_setDocumentLocator:)]) {
        _xmlHandler.setDocumentLocator = yd_setDocumentLocatorxmlHandler;
    }
    else {
        _xmlHandler.setDocumentLocator = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_startDocument:)]) {
        _xmlHandler.startDocument = yd_startDocumentxmlHandler;
    }
    else {
        _xmlHandler.startDocument = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_endDocument:)]) {
        _xmlHandler.endDocument = yd_endDocumentxmlHandler;
    }
    else {
        _xmlHandler.endDocument = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_startElement:)]) {
        _xmlHandler.startElement = yd_startElementxmlHandler;
    }
    else {
        _xmlHandler.startElement = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_endElement:)]) {
        _xmlHandler.endElement = yd_endElementxmlHandler;
    }
    else {
        _xmlHandler.endElement = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_reference:)]) {
        _xmlHandler.reference = yd_referencexmlHandler;
    }
    else {
        _xmlHandler.reference = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_characters:)]) {
        _xmlHandler.characters = yd_charactersxmlHandler;
    }
    else {
        _xmlHandler.characters = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_ignorableWhitespace:)]) {
        _xmlHandler.ignorableWhitespace = yd_ignorableWhitespacexmlHandler;
    }
    else {
        _xmlHandler.ignorableWhitespace = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_processingInstruction:)]) {
        _xmlHandler.processingInstruction = yd_processingInstructionxmlHandler;
    }
    else {
        _xmlHandler.processingInstruction = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_comment:)]) {
        _xmlHandler.comment = yd_commentxmlHandler;
    }
    else {
        _xmlHandler.comment = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_warning:)]) {
        _xmlHandler.warning = yd_warningxmlHandler;
    }
    else {
        _xmlHandler.warning = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_error:)]) {
        _xmlHandler.error = yd_errorxmlHandler;
    }
    else {
        _xmlHandler.error = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_fatalError:)]) {
        _xmlHandler.fatalError = yd_fatalErrorxmlHandler;
    }
    else {
        _xmlHandler.fatalError = NULL;
    }
    
//    if ([delegate respondsToSelector:@selector(yd_getParameterEntity:)]) {
//        _xmlHandler.getParameterEntity = yd_getParameterEntityxmlHandler;
//    }
//    else {
//        _xmlHandler.getParameterEntity = NULL;
//    }
    
    if ([delegate respondsToSelector:@selector(yd_cdataBlock:)]) {
        _xmlHandler.cdataBlock = yd_cdataBlockHandler;
    }
    else {
        _xmlHandler.cdataBlock = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_externalSubset:)]) {
        _xmlHandler.externalSubset = yd_externalSubsetxmlHandler;
    }
    else {
        _xmlHandler.externalSubset = NULL;
    }
    
//    if ([delegate respondsToSelector:yd_initialized:]) {
//        _xmlHandler.initialized = yd_initializedxmlHandler;
//    }
//    else {
//        _xmlHandler.initialized = NULL;
//    }
    
//    if ([delegate respondsToSelector:@selector(yd__private:)]) {
//        _xmlHandler._private = yd__privatexmlHandler;
//    }
//    else {
//        _xmlHandler._private = NULL;
//    }
    
    if ([delegate respondsToSelector:@selector(yd_startElementNs:)]) {
        _xmlHandler.startElementNs = yd_startElementNsxmlHandler;
    }
    else {
        _xmlHandler.startElementNs = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_endElementNs:)]) {
        _xmlHandler.endElementNs = yd_endElementNsxmlHandler;
    }
    else {
        _xmlHandler.endElementNs = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(yd_serror:)]) {
        _xmlHandler.serror = yd_serrorxmlHandler;
    }
    else {
        _xmlHandler.serror = NULL;
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
        xmlSAX2InitHtmlDefaultSAXHandler(&_xmlHandler);
        self.delegate = nil; // 设置默认处理（没有处理）否则将会崩溃,否则存在野指针
    }
    return self;
}

@end
