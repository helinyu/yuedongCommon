//
//  YDHtmlElementModel.h
//  TestCoreText
//
//  Created by mac on 8/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.H>
#import "YDExtension.h"

@interface YDHtmlElementModel : NSObject <YYModel>

@property (nonatomic, copy) NSString *writingdirectionStr; //字写方向字符串
@property (nonatomic, assign) NSWritingDirection writingDirection; // 写的方向

@property (nonatomic, copy) NSString *beforeContent;

// need to get value fot them
@property (nonatomic, copy) NSString *fontSizeStr;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat textScale;
@property (nonatomic, assign) CGFloat pointSize;

@property (nonatomic, copy) NSString *colorName;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) NSString *backgroundColorName;
@property (nonatomic, strong) UIColor *backgroundColor;

//浮動
@property (nonatomic, copy) NSString *floatString;
@property (nonatomic, assign) YDHTMLElementFloatStyle floatStyle;

//text decoration
@property (nonatomic, copy) NSString *textDecorationStr;
@property (nonatomic, assign) YDTextDecorationStyle textDecoration;

// test align
@property (nonatomic, copy) NSString *textAlignStr;
@property (nonatomic, assign) CTTextAlignment textAlign;

@property (nonatomic, copy) NSString *verticalAlignStr;
@property (nonatomic, assign) YDTextAttachmentVerticalAlignment verticalAlign;

// 字母空隙
@property (nonatomic, copy) NSString *letterSpacingStr;
@property (nonatomic, assign) CGFloat letterSpacing;

@property (nonatomic, copy) NSString *lineHeightStr;
@property (nonatomic, assign) CGFloat lineHeight;

@property (nonatomic, copy) NSString *minimumLineHeightStr;
@property (nonatomic, assign) CGFloat minimumLineHeight;

@property (nonatomic, copy) NSString *maximumLineHeightStr;
@property (nonatomic, assign) CGFloat maximumLineHeight;

@property (nonatomic, copy) NSString *fontVariantStr;
@property (nonatomic, assign) YDHTMLElementFontVariant fontVariant;

@property (nonatomic, copy) NSString *widthStr;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, copy) NSString *heightStr;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) NSString *whiteSpaceStr;
@property (nonatomic, assign) BOOL preserveNewLines;

@property (nonatomic, copy) NSString *displayStr;
@property (nonatomic, assign) YDHTMLElementDisplayStyle displayStyle;

@property (nonatomic, copy) NSString *borderColorStr;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, copy) NSString *borderWidthStr;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, copy) NSString *borderRadiuStr;
@property (nonatomic, assign) CGFloat borderRadius;

@property (nonatomic, copy) NSString *textIndentStr;
@property (nonatomic, assign) CGFloat textIndent;

@property (nonatomic, copy) NSString *fontWeightStr;
@property (nonatomic, assign) YDHTMLFontWeightStyle fontWeight;

@property (nonatomic, copy) NSString *textShadowStr;
@property (nonatomic, strong) NSArray *textShadows;

@property (nonatomic, copy) NSString *coretextFontname;

@property (nonatomic, copy) NSString *fontStyleStr;
@property (nonatomic, assign) YDHTMLFontStyle fontStyle;

@property (nonatomic, copy) id fontFamilyStr;
@property (nonatomic, strong) NSArray *fontFamilyStyle;

@end
