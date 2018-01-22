//
//  CTFrameParserConfig.m
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

- (id)init {
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor orangeColor];
        _textBgColor = [UIColor purpleColor];
        _fontText = @"PingFangSC-Regular";
        _font = [UIFont fontWithName:_fontText size:_fontSize];
    }
    return self;
}

@end
