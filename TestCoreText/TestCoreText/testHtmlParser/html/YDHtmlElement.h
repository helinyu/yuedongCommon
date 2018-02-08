//
//  YDHtmlElement.h
//  TestCoreText
//
//  Created by mac on 8/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHtmlParserNode.h"

@interface YDHtmlElement : YDHtmlParserNode

// base property
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, copy) NSString *fontName;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;

// out put property
@property (nonatomic, copy) NSAttributedString *attributedString;

//apply for the styles
- (void)applyForStyles:(NSDictionary *)styles;

@end
