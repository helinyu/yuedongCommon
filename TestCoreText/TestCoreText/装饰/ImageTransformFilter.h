//
//  ImageTransformFilter.h
//  TestCoreText
//
//  Created by Aka on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ImageFilter.h"

@interface ImageTransformFilter : ImageFilter

@property (nonatomic, assign) CGAffineTransform transForm;
- (id)initWithImageComponent:(id<ImageComponent>)component transform:(CGAffineTransform)transform;
- (void)apply;

@end
