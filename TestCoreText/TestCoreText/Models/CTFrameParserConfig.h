 //
//  CTFrameParserConfig.h
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 配置是配置样式
@interface CTFrameParserConfig : NSObject

@property (nonatomic, assign) CGFloat width; // 文字的宽度？？
@property (nonatomic, assign) CGFloat fontSize; // 文字大小 （字体和大小？）
@property (nonatomic, assign) CGFloat lineSpace; // 行间距
@property (nonatomic, strong) UIColor *textColor;// 文字颜色
@property (nonatomic, strong) UIColor *textBgColor; // 文字的背景颜色
@property (nonatomic, copy) NSString *fontText; // 是什么字体？
@property (nonatomic, copy) UIFont *font; // 文字的字体 （大小和字体）

@end
