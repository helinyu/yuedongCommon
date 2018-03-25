//
//  YDFactoryViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDFactoryViewController.h"
#import "CanvasView.h"
#import "CanvasGenerator.h"
#import "PaperCanvasViewController.h"
#import "YDClothViewController.h"

@interface YDFactoryViewController ()

@property (nonatomic, strong) CanvasView *canvasView;

@end

@implementation YDFactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    CanvasGenerator *generator = [CanvasGenerator new];
    PaperCanvasViewController *generator = [PaperCanvasViewController new];
     [self loadCanvasViewWithGenerator:generator];
}

- (void)loadCanvasViewWithGenerator:(CanvasGenerator *)generator {
    [_canvasView removeFromSuperview];
    _canvasView = [CanvasView new];
    CGRect aFrame = CGRectMake(0.f, 100.f, [UIScreen mainScreen].bounds.size.width, 436.f);
    CanvasView *aCanvasView = [generator canvasViewWithFrame:aFrame];
    _canvasView = aCanvasView;
    [self.view addSubview:aCanvasView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
