//
//  FirstViewController.m
//  test
//
//  Created by felix on 2017/5/8.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "FirstViewController.h"
#import "Masonry.h"
#import "MASExampleUpdateView.h"

@interface FirstViewController ()

@property (strong , nonatomic) MASExampleUpdateView *subview;

@end


@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subview = [[MASExampleUpdateView alloc] init];
    self.subview.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.subview];
    
}

- (void)actionAnimation:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
