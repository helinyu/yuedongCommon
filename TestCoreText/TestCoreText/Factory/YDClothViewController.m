//
//  YDClothViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDClothViewController.h"
#import "ClosCanvasView.h"

@interface YDClothViewController ()

@end

@implementation YDClothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (CanvasView *)canvasViewWithFrame:(CGRect)frame {
    return [[ClosCanvasView alloc] initWithFrame:frame];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
