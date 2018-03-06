//
//  ImageTransformFilter.m
//  TestCoreText
//
//  Created by Aka on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ImageTransformFilter.h"

@implementation ImageTransformFilter

- (id)initWithImageComponent:(id<ImageComponent>)component transform:(CGAffineTransform)transform {
    if (self = [super initWithImageComponent:component]) {
        [self setTransForm:transform];
    }
    return self;
}

- (void)apply {
    CGContextRef conText = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(conText, _transForm);
}

@end
