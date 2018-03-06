//
//  ImageShadowFilter.m
//  TestCoreText
//
//  Created by Aka on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ImageShadowFilter.h"

@implementation ImageShadowFilter

- (void)apply{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize offset = CGSizeMake(-25, 15);
    CGContextSetShadow(context, offset, 20.0);
}

@end
