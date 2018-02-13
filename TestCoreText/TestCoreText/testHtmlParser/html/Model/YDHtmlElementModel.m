//
//  YDHtmlElementModel.m
//  TestCoreText
//
//  Created by mac on 8/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHtmlElementModel.h"
#import "YDExtension.h"

@implementation YDHtmlElementModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"WritingdirectionStr" : @"direction",
             @"beforeContent" : @"before:content",
             @"fontSizeStr" : @"font-size",
             @"colorName" : @"color",
             @"backgroundColorName" : @"background-color",
             @"floatString" : @"float",
             @"textDecorationStr" : @"text-decoration",
             @"textAlign" : @"text-align",
             @"verticalAlign" : @"vertical-align",
             @"letterSpacingStr" : @"letter-spacing",
             @"lineHeight" : @"line-height",
             @"minimumLineHeightStr" : @"minimum-line-height",
             @"maximumLineHeight" : @"maximum-line-height",
             @"fontVariantStr" : @"font-variant",
             @"widthStr" : @"width",
             @"heightStr" : @"height",
             @"whiteSpaceStr" : @"white-space",
             @"displayStyle" : @"display",
             @"borderColorStr" : @"border-color",
             @"borderWidthStr" : @"border-width",
             @"borderRadiusStr" : @"border-radius",
             @"textIndentStr" : @"text-indent",
             @"fontWeightStr" : @"font-weight",
             @"textShadowStr" : @"text-shadow",
             @"coretextFontname" : @"-coretext-fontname",
             @"fontStyleStr" : @"font-style",
             @"fontFamilyStr" : @"font-family",
             };

}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
//             @"eventTrack": [YDAdEventTrack class]
             };
}

- (NSString *)description {
    return [self yy_modelDescription];
}


// getter methods

- (NSWritingDirection)writingDirection {
    if (_writingdirectionStr.length >0) {
        if ([_writingdirectionStr isEqualToString:@"rtl"]) {
            return NSWritingDirectionRightToLeft;
        }
        else if ([_writingdirectionStr isEqualToString:@"ltr"]) {
            return NSWritingDirectionLeftToRight;
        }
        else if ([_writingdirectionStr isEqualToString:@"auto"]) {
            return NSWritingDirectionNatural;
        }else {
            return NSWritingDirectionNatural;
        }
    }
    else {
        return NSWritingDirectionNatural;
    }
}

//text color
- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = (UIColor *)CreateColorWithHtmlName(_colorName);
    }
    return _textColor;
}

- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = (UIColor *)CreateColorWithHtmlName(_backgroundColorName);
    }
    return _backgroundColor;
}

- (YDHTMLElementFloatStyle)floatStyle {
    if (_floatString.length >0) {
        if ([_floatString isEqualToString:@"left"]) {
            _floatStyle = YDHTMLElementFloatStyleLeft;
        }
        else if ([_floatString isEqualToString:@"right"]) {
            _floatStyle = YDHTMLElementFloatStyleRight;
        }
        else if ([_floatString isEqualToString:@"none"]) {
            _floatStyle = YDHTMLElementFloatStyleNone;
        }
    }
    return _floatStyle;
}

- (YDTextDecorationStyle)textDecoration {
    YDTextDecorationStyle style =YDTextDecorationStyleNoneAttribute;
    if (_textDecorationStr.length >0) {
        if ([_textDecorationStr isEqualToString:@"underline"]) {
            style = YDTextDecorationStyleUnderLineSingle;
        }
        else if ([_textDecorationStr isEqualToString:@"overline"]) {
            style = YDTextDecorationStyleOverLine;
        }
        else if ([_textDecorationStr isEqualToString:@"line-through"]) {
            style = YDTextDecorationStyleLineThrough;
        }
        else if ([_textDecorationStr isEqualToString:@"blink"]) {
            style = YDTextDecorationStyleBlink;
        }
        else if ([_textDecorationStr isEqualToString:@"inherit"]) {
            style = YDTextDecorationStyleInherit;
        }else if ([_textDecorationStr isEqualToString:@"none"]) {
            style = YDTextDecorationStyleNone;
        }
        else {
            style = YDTextDecorationStyleNoneAttribute;
        }
    }
    else {
        style = YDTextDecorationStyleNoneAttribute;
    }
    return style;
}

- (CTTextAlignment)textAlign {
    if (_textDecorationStr.length >0) {
        if ([_textDecorationStr isEqualToString:@"left"]) {
            _textAlign = kCTTextAlignmentLeft;
        }
        else if ([_textDecorationStr isEqualToString:@"right"]) {
            _textAlign = kCTTextAlignmentRight;
        }
        else if ([_textAlignStr isEqualToString:@"cent er"]) {
            _textAlign = kCTTextAlignmentCenter;
        }
        else if ([_textAlignStr isEqualToString:@"justify"]) {
            _textAlign = kCTTextAlignmentJustified;
        }
        else if ([_textAlignStr isEqualToString:@"inherit"]) {
            _textAlign = -1;
        }else {
            _textAlign = -1;
        }
    }
    else {
        _textAlign = -1;
    }
    return _textAlign;
}

// alignment
- (YDTextAttachmentVerticalAlignment)verticalAlign {
    if (_verticalAlignStr.length >0) {
        
        if ([_verticalAlignStr isEqualToString:@"text-top"]) {
            _verticalAlign = YDTextAttachmentVerticalAlignmentTop;
        }
        else if ([_verticalAlignStr isEqualToString:@"middle"]) {
            _verticalAlign = YDTextAttachmentVerticalAlignmentCenter;
        }
        else if ([_verticalAlignStr isEqualToString:@"text-bottom"]) {
            _verticalAlign = YDTextAttachmentVerticalAlignmentBottom;
        }
        else if ([_verticalAlignStr isEqualToString:@"baseline"]) {
            _verticalAlign = YDTextAttachmentVerticalAlignmentBaseline;
        }
        else if ([_verticalAlignStr isEqualToString:@"sub"]) {
            _verticalAlign = YDTextAttachmentVerticalAlignmentSub;
        }
        else if ([_verticalAlignStr isEqualToString:@"super"]) {
            _verticalAlign = YDTextAttachmentVerticalAlignmentSuper;
        }
        else if ([_verticalAlignStr isEqualToString:@"inherit"]) {
            _verticalAlign = YDTextAttachmentVerticalAlignmentInherit;
        }
        else{
            _verticalAlign = -1;
        }
    }
    else {
        _verticalAlign = -1;
    }
    return _verticalAlign;
}

- (CGFloat)letterSpacing {
    if (_letterSpacingStr.length >0) {
        if ([_letterSpacingStr isEqualToString:@"normal"] || [_letterSpacingStr isEqualToString:@"inherit"]) {
            return 0.f;
        }else {
#warning --need to change
//            return [letterSpacing pixelSizeOfCSSMeasureRelativeToCurrentTextSize:self.fontDescriptor.pointSize textScale:_textScale];
            return 0.f;
        }
    }
    return 0.f;
}

- (CGFloat)lineHeight {
    if (_lineHeightStr.length >0) {
        if ([_lineHeightStr.lowercaseString isEqualToString:@"normal"]) {
            return 0.f;
        }
        else if ([_lineHeightStr.lowercaseString isEqualToString:@"inherit"]) {
            return -CGFLOAT_MAX;
        }
        else if ([_lineHeightStr yd_isNumeric]) {
            return _lineHeightStr.floatValue;
        }
        else {
//            CGFloat lineHeightValue = [lineHeight pixelSizeOfCSSMeasureRelativeToCurrentTextSize:self.fontDescriptor.pointSize textScale:_textScale];
//            self.paragraphStyle.minimumLineHeight = lineHeightValue;
//            self.paragraphStyle.maximumLineHeight = lineHeightValue;
            return -CGFLOAT_MAX;
        }
    }
    else {
        return -CGFLOAT_MAX;
    }
}

- (CGFloat)minimumLineHeight {
    if (_minimumLineHeightStr.length >0) {
        if ([_minimumLineHeightStr isEqualToString:@"normal"] || [_minimumLineHeightStr isEqualToString:@"inherit"]) {
            return -CGFLOAT_MAX;
        }
        else if ([_minimumLineHeightStr yd_isNumeric]) {
            return _minimumLineHeightStr.floatValue;
        }
        else {
//            CGFloat minimumLineHeightValue = [minimumLineHeight pixelSizeOfCSSMeasureRelativeToCurrentTextSize:self.fontDescriptor.pointSize textScale:_textScale];
//            self.paragraphStyle.minimumLineHeight = minimumLineHeightValue;
#warning  --- need to change
            return -CGFLOAT_MAX;
        }
    }else {
        return -CGFLOAT_MAX;
    }
}

- (CGFloat)maximumLineHeight {
    if (_maximumLineHeightStr.length >0) {
        if ([_maximumLineHeightStr.lowercaseString isEqualToString:@"normal"] || [_maximumLineHeightStr isEqualToString:@"inherit"]) {
            return -CGFLOAT_MAX;
        }
        else if ([_maximumLineHeightStr yd_isNumeric]) {
            return _maximumLineHeightStr.floatValue;
        }
        else {
//            CGFloat maximumLineHeightValue = [maximumLineHeight pixelSizeOfCSSMeasureRelativeToCurrentTextSize:self.fontDescriptor.pointSize textScale:_textScale];
//            self.paragraphStyle.maximumLineHeight = maximumLineHeightValue;
            return -CGFLOAT_MAX;
        }
    }
    else {
        return -CGFLOAT_MAX;
    }
}

- (YDHTMLElementFontVariant)fontVariant {
    if (_fontVariantStr.length >0) {
        if ([_fontVariantStr.lowercaseString isEqualToString:@"small-caps"]) {
            _fontVariant =
            YDHTMLElementFontVariantSmallCaps;
        }
        else if ([_fontVariantStr isEqualToString:@"inherit"])
        {
            _fontVariant =
            YDHTMLElementFontVariantInherit;
        }
        else
        {
            _fontVariant = YDHTMLElementFontVariantNormal;
        }
    }
    else {
         _fontVariant = -1;
    }
    return _fontVariant;
}

- (CGFloat)width {
    if (_widthStr && ![_widthStr isEqualToString:@"auto"])
    {
//        _size.width = [widthString pixelSizeOfCSSMeasureRelativeToCurrentTextSize:self.fontDescriptor.pointSize textScale:_textScale];
        return 0.f;
    }
    return 0.f;
}

- (CGFloat)height {
    if (_heightStr && ![_heightStr isEqualToString:@"auto"])
    {
//        _size.height = [heightString pixelSizeOfCSSMeasureRelativeToCurrentTextSize:self.fontDescriptor.pointSize textScale:_textScale];
        return 0.f;
    }
    return 0.f;
}

- (BOOL)preserveNewLines {
    if ([_whiteSpaceStr hasPrefix:@"pre"])
    {
        _preserveNewLines = YES;
    }
    else
    {
        _preserveNewLines = NO;
    }
    return _preserveNewLines;
}

- (YDHTMLElementDisplayStyle)displayStyle {
    if (_displayStr.length >0)
    {
        if ([_displayStr.lowercaseString isEqualToString:@"none"])
        {
            _displayStyle = YDHTMLElementDisplayStyleNone;
        }
        else if ([_displayStr.lowercaseString isEqualToString:@"block"])
        {
            _displayStyle = YDHTMLElementDisplayStyleBlock;
        }
        else if ([_displayStr.lowercaseString isEqualToString:@"inline"])
        {
            _displayStyle =
            YDHTMLElementDisplayStyleInline;
        }
        else if ([_displayStr.lowercaseString isEqualToString:@"list-item"])
        {
            _displayStyle =
            YDHTMLElementDisplayStyleListItem;
        }
        else if ([_displayStr.lowercaseString isEqualToString:@"table"])
        {
            _displayStyle = YDHTMLElementDisplayStyleTable;
        }
        else if ([_displayStr.lowercaseString isEqualToString:@"inherit"])
        {
            // nothing to do
            _displayStyle = -1;
        }
    }
     _displayStyle = -1;
     return _displayStyle;
}

- (UIColor *)borderColor {
    if (_borderColorStr.length >0) {
        return CreateColorWithHtmlName(_borderColorStr);
    }
    return nil;
}

- (CGFloat)borderWidth {
    if (_borderWidthStr.length >0) {
        return _borderWidthStr.floatValue;
    }
    return 0.f;
}

- (CGFloat)borderRadius {
    if (_borderRadiuStr.length >0) {
        return _borderRadiuStr.floatValue;
    }
    return 0.f;
}

- (CGFloat)textIndent {
    if (_textIndentStr.length >0) {
//        && [_textIndentStr isAccessibilityElement]) {
//        _pTextIndent = [textIndentStr pixelSizeOfCSSMeasureRelativeToCurrentTextSize:_currentTextSize textScale:_textScale];
        return 0.f;
    }
    return 0.f;
}

//BOOL needsTextBlock = (_backgroundColor!=nil || _backgroundStrokeColor!=nil || _backgroundCornerRadius > 0 || _backgroundStrokeWidth > 0);
//
//BOOL hasMargins = NO;
//
//NSString *allKeys = [[styles allKeys] componentsJoinedByString:@";"];

//fontWeight
- (YDHTMLFontWeightStyle)fontWeight {
    if (_fontWeightStr.length >0) {
        if ([_fontWeightStr isEqualToString:@"normal"]) {
            _fontWeight = YDHTMLFontWeightStyleNormal;
        }
        else if ([_fontWeightStr isEqualToString:@"bold"]) {
            _fontWeight = YDHTMLFontWeightStyleBold;
        }
        else if ([_fontWeightStr isEqualToString:@"bolder"]) {
            _fontWeight = YDHTMLFontWeightStyleBolder;
        }
        else if ([_fontWeightStr isEqualToString:@"lighter"]) {
            _fontWeight = YDHTMLFontWeightStyleLighter;
        }
        else {
            if (_fontWeightStr.floatValue <= 600) {
                _fontWeight = YDHTMLFontWeightStyleLessThan600;
            }
            else {
                _fontWeight = YDHTMLFontWeightStyleLargerThan600;
            }
        }
    }
    else {
        _fontWeight = YDHTMLFontWeightStyleNone;
    }
    return _fontWeight;
}

#warning need change

//- (NSArray *)textShadows {
//    if (_textShadowStr.length >0) {
//        _textShadows = @[];
//    }
//    _textShadows = @[],
////    self.shadows = [shadow arrayOfCSSShadowsWithCurrentTextSize:_fontDescriptor.pointSize currentColor:_textColor];
//    return @[];
//}

- (YDHTMLFontStyle)fontStyle {
    if (_fontStyleStr.length >0) {
        if ([_fontStyleStr isEqualToString:@"normal"]) {
            _fontStyle =YDHTMLFontStyleNormal;
        }
        else if ([_fontStyleStr isEqualToString:@"Italic"]) {
            _fontStyle =YDHTMLFontStyleItalic;
        }
        else if ([_fontStyleStr isEqualToString:@"oblique"]) {
            _fontStyle =YDHTMLFontStyleOblique;
        }
        else if ([_fontStyleStr isEqualToString:@"inherit"]) {
            _fontStyle =YDHTMLFontStyleInherit;
        }
        else {
            _fontStyle = YDHTMLFontStyleNone;
        }
    }
    else {
        _fontStyle = YDHTMLFontStyleNone;
    }
    return _fontStyle;
}

- (NSArray *)fontFamilyStyle {
    if ([_fontFamilyStr isKindOfClass:[NSString class]]) {
        _fontFamilyStyle = [NSArray arrayWithObject:_fontFamilyStr];
    }
    else if ([_fontFamilyStr isKindOfClass:[NSArray class]]) {
        _fontFamilyStyle =  _fontFamilyStr;
    }
    return _fontFamilyStyle;
}

- (CGFloat)fontSize {
    if (_fontSizeStr.length >0)
    {
        // absolute sizes based on 12.0 CoreText default size, Safari has 16.0
        if ([_fontSizeStr isEqualToString:@"smaller"])
        {
            _fontSize = YDHTMLFontSizeStyleSmaller;
        }
        else if ([_fontSizeStr isEqualToString:@"larger"])
        {
            _fontSize = YDHTMLFontSizeStyleLarger;
        }
        else if ([_fontSizeStr isEqualToString:@"xx-small"])
        {
            _fontSize = YDHTMLFontSizeStyleXXSmall;
        }
        else if ([_fontSizeStr isEqualToString:@"x-small"])
        {
            _fontSize = YDHTMLFontSizeStyleXSmall;
        }
        else if ([_fontSizeStr isEqualToString:@"small"])
        {
            _fontSize = YDHTMLFontSizeStyleSmall;
        }
        else if ([_fontSizeStr isEqualToString:@"medium"])
        {
            _fontSize = YDHTMLFontSizeStyleMedium;
        }
        else if ([_fontSizeStr isEqualToString:@"large"])
        {
            _fontSize = YDHTMLFontSizeStyleLarge;
        }
        else if ([_fontSizeStr isEqualToString:@"x-large"])
        {
            _fontSize = YDHTMLFontSizeStyleXLarge;
        }
        else if ([_fontSizeStr isEqualToString:@"xx-large"])
        {
            _fontSize = YDHTMLFontSizeStyleXXLarge;
        }
        else if ([_fontSizeStr isEqualToString:@"-webkit-xxx-large"])
        {
            _fontSize = YDHTMLFontSizeStyleWebkitXXXLarge;
        }
        else if ([_fontSizeStr isEqualToString:@"inherit"])
        {
            _fontSize = YDHTMLFontSizeStyleInherit;
        }
//        else if ([_fontSizeStr isCSSLengthValue])
//        {
//            _fontSize = YDHTMLFontSizeStyleCSSLengthValue;
//        }
        else {
            _fontSize =YDHTMLFontSizeStyleDefault;
        }
    }
    else {
        _fontSize = YDHTMLFontSizeStyleDefault;
    }
    return _fontSize;
}


@end
