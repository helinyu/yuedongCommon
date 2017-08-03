//
//  LYNewViewController.m
//  test
//
//  Created by felix on 2017/5/27.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "LYNewViewController.h"
#import "Masonry.h"
#import "WTKNavigationController.h"
#import "LYNewToViewController.h"

@interface LYNewViewController ()

@end

@implementation LYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

- (void)toAction:(UIButton *)sender {
    LYNewToViewController *vc = [[LYNewToViewController alloc]init];
    WTKNavigationController *navi = [[WTKNavigationController alloc] initWithRootViewController:vc];
    navi.animationType = 3;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
