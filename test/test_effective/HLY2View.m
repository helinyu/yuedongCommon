//
//  HLY2View.m
//  test_effective
//
//  Created by Aka on 2017/10/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLY2View.h"

@implementation HLY2View

// 响应事件上的 三种类型的方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"view2 began touches :%@  \n event : %@",touches, event);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"view2 moved touches :%@ \n event : %@",touches, event);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"view2 ended touches :%@ \n event : %@",touches, event);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"view2 cancel touches :%@ \n event : %@",touches, event);
}

@end
