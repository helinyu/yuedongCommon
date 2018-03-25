//
//  CanvasViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CanvasViewController.h"
#import "CanvasView.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (CanvasView *)canvasViewFrame:(CGRect)frame {
    return [[CanvasView alloc] initWithFrame:frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
