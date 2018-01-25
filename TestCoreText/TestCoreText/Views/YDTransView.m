//
//  YDTransView.m
//  TestCoreText
//
//  Created by mac on 25/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTransView.h"

@implementation YDTransView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    CALayer *sonLayer = [CALayer new];
    [self.layer addSublayer:sonLayer];
    sonLayer.backgroundColor = [UIColor redColor].CGColor;
    sonLayer.frame = CGRectMake(20, 20, 10, 40);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
}


@end
