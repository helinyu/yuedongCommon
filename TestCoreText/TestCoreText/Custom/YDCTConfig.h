//
//  YDCTConfig.h
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YDCTConfig : NSObject

@property (nonatomic, assign) CGFloat width; // 宽度
@property (nonatomic, assign) CGFloat fontSize; // 字的大小
@property (nonatomic, assign) CGFloat lineSpace; // 行的间距
@property (nonatomic, strong) UIColor *textColor; // 文字颜色

@end
