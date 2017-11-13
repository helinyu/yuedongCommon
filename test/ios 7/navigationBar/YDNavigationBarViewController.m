//
//  YDNavigationBarViewController.m
//  ios 7
//
//  Created by Aka on 2017/11/13.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDNavigationBarViewController.h"
#import "Masonry.h"
#import "YDTitleView.h"

@interface YDNavigationBarViewController ()

//@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) YDTitleView *titleView;

@end

@implementation YDNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    YDTitleView *titleView = [YDTitleView new];
    titleView.backgroundColor = [UIColor redColor];
    titleView.frame = CGRectMake(0, 0, 100, 100);
    self.navigationItem.titleView = titleView;
    _titleView = titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
