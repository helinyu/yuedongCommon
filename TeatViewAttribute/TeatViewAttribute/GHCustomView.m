//
//  GHCustomView.m
//  TeatViewAttribute
//
//  Created by mac on 23/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GHCustomView.h"

@implementation GHCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGSize)intrinsicContentSize {
    NSLog(@"size");
    return CGSizeMake(400, 400);
}

- (void)invalidateIntrinsicContentSize NS_AVAILABLE_IOS(6_0) {
    //     当前的view添加到父view的时候，才会进行调用
    NSLog(@"gh custom view -invalidateIntrinsicContentSize");
}

@end
