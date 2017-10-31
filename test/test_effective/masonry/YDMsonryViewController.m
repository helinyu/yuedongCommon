//
//  YDMsonryViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/30.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDMsonryViewController.h"
#import "Masonry.h"

@interface YDMsonryViewController ()

@property (nonatomic, strong) UIView *orangeView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation YDMsonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    {
        _orangeView = [UIView new];
        [self.view addSubview:_orangeView];
        [_orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.view).offset(80.f);
            make.right.bottom.equalTo(self.view).offset(-80.f);
        }];
        _orangeView.backgroundColor = [UIColor orangeColor];
    }
    
    {
        _lineView = [UIView new];
        [_orangeView addSubview:_lineView];
        _lineView.backgroundColor = [UIColor blueColor];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_orangeView);
            make.left.equalTo(_orangeView).mas_offset(_orangeView.mas_width).dividedBy(3.f);
            make.width.mas_equalTo(30.f);
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
