//
//  SecondViewController.m
//  test
//
//  Created by felix on 2017/5/8.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondView.h"
#import "Masonry.h"

@interface SecondViewController ()

//@property (strong, nonatomic) UIView *secondView;
@property (strong, nonatomic) UIView *animationView;
@property (assign, nonatomic) CGFloat radio;
@property (assign, nonatomic) NSInteger radioTimes;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 50, 100);
    [btn addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn setTitle:@"变化" forState:UIControlStateNormal];
    
    self.animationView = [[UIView alloc] init];
    [self.view addSubview:self.animationView];
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(10);
        make.center.equalTo(self.view);
    }];
    
    self.animationView.layer.cornerRadius = 5;
    self.animationView.backgroundColor = [UIColor greenColor];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.height;
    self.radio = sqrt(pow(screenWidth,2)+pow(screenHeight,2));
    CGFloat smallRadio = sqrt(5*5+5*5);
    self.radioTimes = self.radio/smallRadio + 1;
}

- (void)onTap {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didTapGrowButton:(UIButton *)sender {
    
}

@end
