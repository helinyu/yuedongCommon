//
//  HLYScrollViewController.m
//  test
//
//  Created by felix on 2017/6/2.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYScrollViewController.h"

@interface HLYScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HLYScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor yellowColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor greenColor];
    self.scrollView.layer.borderWidth = 1;
    self.navigationController.hidesBarsOnSwipe = NO;

    
    NSLog(@"navigatioan push time : %f",UINavigationControllerHideShowBarDuration);
    [self test0];
}

- (void)test0 {
    self.scrollView.contentSize = self.scrollView.bounds.size;
    self.scrollView.tintColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
