//
//  VCToPresentedTransitionViewController.m
//  test
//
//  Created by felix on 2017/5/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "VCToPresentedTransitionViewController.h"
#import "Masonry.h"

@interface VCToPresentedTransitionViewController ()

@end

@implementation VCToPresentedTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor blackColor];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)toAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
