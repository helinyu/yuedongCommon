//
//  YDCTUnit.h
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YDCTImageModel;
@class YDCTModel;
@class YDCTLinkModel;

@interface YDCTUtils : NSObject

// 点击的出发动作 返回的额link的内容
+ (YDCTLinkModel *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(YDCTModel *)data;

// 点击在view上的位置
+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(YDCTModel *)data;

@end
