//
//  YDVerticalView.m
//  test_effective
//
//  Created by Aka on 2017/10/23.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDVerticalView.h"

@implementation YDVerticalView

+ (Class)layerClass {
    return [CATextLayer class];
}
//- (void)drawText:(NSString *)text x:(float)x y:(float)y {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSelectFont(context, "Arial", 20, kCGEncodingMacRoman);
//    CGContextSetTextDrawingMode(context, kCGTextFill);
//    CGAffineTransform xform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
//    CGContextSetTextMatrix(context, xform);
//    CGContextSetTextPosition(context, x, y+20); // 20 is y-axis offset pixels
//    CGContextShowText(context, [text UTF8String], strlen([text UTF8String]));
//    //    http://www.cnblogs.com/w-zhijun/archive/2012/05/14/2499089.html 看看是如何进行绘制出文字在view上，应该是UIlabel 中已经有方向了
//}
@end
