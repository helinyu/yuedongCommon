//
//  YDExtension.h
//  TestCoreText
//
//  Created by mac on 8/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

extern UIColor* CreateColorWithHtmlName(NSString *colorName);
extern NSString* HexStrigFromColorByGrayScale(CGFloat *components, NSString *stringFormat);
extern NSString* HexStringFromColorByRGB(CGFloat *components, NSString *stringFormat);

// mapping the element float style
typedef NS_ENUM(NSUInteger, YDHTMLElementFloatStyle)
{
    YDHTMLElementFloatStyleNone = 0,
    YDHTMLElementFloatStyleLeft,
    YDHTMLElementFloatStyleRight
};

//text decoration
typedef CF_OPTIONS(int32_t, YDTextDecorationStyle) {
    YDTextDecorationStyleNoneAttribute = -0x01,
    YDTextDecorationStyleNone = 0x00,
    YDTextDecorationStyleUnderLineSingle = 0x01,
    YDTextDecorationStyleUnderLineThick = 0x02,
    YDTextDecorationStyleUnderLineDouble = 0x03,
    YDTextDecorationStyleLineThrough = 0x04,
    YDTextDecorationStyleOverLine = 0x05,
    YDTextDecorationStyleBlink = 0x06,
    YDTextDecorationStyleInherit = 0x07,
};


// Text Attachment vertical alignment
typedef NS_ENUM(NSUInteger, YDTextAttachmentVerticalAlignment)
{
    YDTextAttachmentVerticalAlignmentBaseline = 0,
    YDTextAttachmentVerticalAlignmentTop,
    YDTextAttachmentVerticalAlignmentCenter,
    YDTextAttachmentVerticalAlignmentBottom,
    YDTextAttachmentVerticalAlignmentSub,
    YDTextAttachmentVerticalAlignmentSuper,
    YDTextAttachmentVerticalAlignmentInherit,
};

//DTHTMLElement font variants
typedef NS_ENUM(NSUInteger, YDHTMLElementFontVariant)
{
    YDHTMLElementFontVariantInherit = 0,
    YDHTMLElementFontVariantNormal,
    YDHTMLElementFontVariantSmallCaps
};


//YDHTMLElement display style
typedef NS_ENUM(NSUInteger, YDHTMLElementDisplayStyle)
{
    YDHTMLElementDisplayStyleInline = 0, // default,   The element is inline text
    YDHTMLElementDisplayStyleNone,//The element is not displayed
    YDHTMLElementDisplayStyleBlock, // The element is a block
    YDHTMLElementDisplayStyleListItem, // The element is an item in a list
    YDHTMLElementDisplayStyleTable, // The element is a table
};

// yd font weight
typedef NS_ENUM(NSUInteger, YDHTMLFontWeightStyle)
{
    YDHTMLFontWeightStyleNone = -1,
    YDHTMLFontWeightStyleNormal = 0,
    YDHTMLFontWeightStyleBold,
    YDHTMLFontWeightStyleBolder,
    YDHTMLFontWeightStyleLighter,
    YDHTMLFontWeightStyleLessThan600, // can be 100 ~ 900
    YDHTMLFontWeightStyleLargerThan600,
};

typedef NS_ENUM(NSUInteger, YDHTMLFontStyle) {
    YDHTMLFontStyleNone = -1,
    YDHTMLFontStyleNormal =0,
    YDHTMLFontStyleItalic,
    YDHTMLFontStyleOblique,
    YDHTMLFontStyleInherit,
};

typedef NS_ENUM(NSUInteger, YDHTMLFontSizeStyle) {
    YDHTMLFontSizeStyleDefault,
    YDHTMLFontSizeStyleSmaller,
    YDHTMLFontSizeStyleLarger,
    YDHTMLFontSizeStyleXXSmall,
    YDHTMLFontSizeStyleXSmall,
    YDHTMLFontSizeStyleSmall,
    YDHTMLFontSizeStyleMedium,
    YDHTMLFontSizeStyleLarge,
    YDHTMLFontSizeStyleXLarge,
    YDHTMLFontSizeStyleXXLarge,
    YDHTMLFontSizeStyleWebkitXXXLarge,
    YDHTMLFontSizeStyleInherit,
    YDHTMLFontSizeStyleCSSLengthValue,
};

@interface YDExtension : NSObject

@end

@interface NSString (YDExtension)

- (BOOL)yd_isNumeric;

@end
