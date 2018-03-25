//
//  CanvasGenerator.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CanvasGenerator.h"
#import "CanvasView.h"

@interface CanvasGenerator ()

@end

@implementation CanvasGenerator

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CanvasView *)canvasViewWithFrame:(CGRect)frame {
    return [[CanvasView alloc] initWithFrame:frame];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
