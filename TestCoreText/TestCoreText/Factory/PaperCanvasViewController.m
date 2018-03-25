//
//  PaperCanvasViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PaperCanvasViewController.h"
#import "PaperCanvasView.h"

@interface PaperCanvasViewController ()

@end

@implementation PaperCanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (CanvasView *)canvasViewWithFrame:(CGRect)frame {
    return [[PaperCanvasView alloc] initWithFrame:frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
