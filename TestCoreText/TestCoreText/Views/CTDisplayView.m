//
//  CTDisplayView.m
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextData.h"

@implementation CTDisplayView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
}


@end
