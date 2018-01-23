
//
//  GHLabel.m
//  TeatViewAttribute
//
//  Created by mac on 23/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GHLabel.h"

@implementation GHLabel

- (CGSize)intrinsicContentSize {
    CGSize superSize = [super intrinsicContentSize];
    NSLog(@"label -super size width: %f, height :%f",superSize.width, superSize.height);
    return superSize;
}

- (void)invalidateIntrinsicContentSize NS_AVAILABLE_IOS(6_0) {
    //     当前的view添加到父view的时候，才会进行调用
    NSLog(@"label -invalidateIntrinsicContentSize");
} // call this when something changes that affects the intrinsicContentSize.  Otherwise UIKit won't notice that it changed.


@end
