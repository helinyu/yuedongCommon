//
//  YDTest16Label.m
//  TestCoreText
//
//  Created by mac on 7/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest16Label.h"

@implementation YDTest16Label


- (void)invalidateIntrinsicContentSize {
    [super invalidateIntrinsicContentSize];
    NSLog(@"取消默认大小");
}

- (CGSize)sizeThatFits:(CGSize)size {
    NSLog(@"size width:%f, height;%f",size.width,size.height);
    return CGSizeMake(60.f, 60.f);
}

@end
