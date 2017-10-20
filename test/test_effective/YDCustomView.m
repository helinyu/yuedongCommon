//
//  YDCustomView.m
//  test_effective
//
//  Created by Aka on 2017/10/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDCustomView.h"

@implementation YDCustomView

// 应该就是渲染出来的内容，我们需要查看yy上面的内容进行处理；

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"point x:%f ,  y:%f , event :%@",point.x, point.y,event);
    NSLog(@"self :%@",self);
    if ([self pointInside:point withEvent:event]) {
        NSLog(@"self");
        return self; // 这个时候，应该是找到了父view，直接就返回了父亲的view了
    }else {
//         多个图片，应该就要看图层的层次关系了
           return [self.subviews.firstObject hitTest:point withEvent:event];
    }
}

@end
