//
//  SetStrokeColorCommand.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SetStrokeColorCommand.h"
#import "CoordinatingViewController.h"
#import "CanvasViewController.h"

@implementation SetStrokeColorCommand

- (void)command:(SetStrokeColorCommand *)command
didRequestColorComponentsForRed:(CGFloat *)red
          green:(CGFloat *)green
           blue:(CGFloat *)blue {
    
}

- (void)execute {
    CGFloat redValue = 0.f;
    CGFloat greenValue = 0.f;
    CGFloat blueValue = 0.f;
    
    [_delegate command:self didRequestColorComponentsForRed:&redValue green:&greenValue blue:&blueValue];
    
    UIColor *color = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
    CoordinatingViewController *coordinator = [CoordinatingViewController shareInstance];
//    CanvasViewController *controller = [coordinator canvansViewController];
//    [controller setStrokerColor:color];
}

@end
