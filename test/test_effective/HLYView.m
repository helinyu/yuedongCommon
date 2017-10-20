//
//  HLYView.m
//  test_effective
//
//  Created by Aka on 2017/10/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYView.h"

@implementation HLYView

// 响应事件上的 三种类型的方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"began touches :%@  \n event : %@",touches, event);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"moved touches :%@ \n event : %@",touches, event);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"ended touches :%@ \n event : %@",touches, event);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"cancel touches :%@ \n event : %@",touches, event);
}

//加速计事件
//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event;
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
//- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event;
//远程控制事件
//- (void)remoteControlReceivedWithEvent:(UIEvent *)event;


@end
