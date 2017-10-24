//
//  YDDrawView.m
//  test_effective
//
//  Created by Aka on 2017/10/23.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDDrawView.h"

@implementation YDDrawView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    
    NSString *text = @"Hello World!";
    
    [self drawText:text x:50 y:0];
    
    [self drawText2:text x:50 y:30];
    
}

- (void)drawText:(NSString *)text x:(float)x y:(float)y {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSelectFont(context, "Arial", 20, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGAffineTransform xform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
    CGContextSetTextMatrix(context, xform);
    CGContextSetTextPosition(context, x, y+20); // 20 is y-axis offset pixels
    CGContextShowText(context, [text UTF8String], strlen([text UTF8String]));
}

- (void) drawText2:(NSString *)text x:(float)x y:(float)y {
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];
    [text drawAtPoint:CGPointMake(x, y) withFont:font];
}

@end
