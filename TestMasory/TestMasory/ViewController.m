//
//  ViewController.m
//  TestMasory
//
//  Created by Aka on 2017/11/15.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *view0;
@property (nonatomic, strong) UIView *view1;
//@property (nonatomic, strong) UIView *view2;

@property (nonatomic, strong) UIView *sonView01;
@property (nonatomic, strong) UIView *sonView02;

@property (nonatomic, strong) UIView *sonView11;
@property (nonatomic, strong) UIView *sonView12;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        _view0 = [UIView new];
        [self.view addSubview:_view0];
        
        _sonView01 = [UIView new];
        [_view0 addSubview:_sonView01];
        
        _sonView02 = [UIView new];
        [_view0 addSubview:_sonView02];
    }
    
    {
        [_view0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.view).offset(50);
            make.width.height.mas_equalTo(300);
        }];
        
        [_sonView01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_view0).offset(50);
            make.width.height.mas_equalTo(100);
        }];
        
        [_sonView02 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.view);
            make.height.width.mas_equalTo(100);
        }];
    }
    
    {
        _view0.backgroundColor = [UIColor grayColor];
        _sonView01.backgroundColor = [UIColor purpleColor];
        _sonView02.backgroundColor = [UIColor yellowColor];
    }
    
    {
        _view1 = [UIView new];
        [self.view addSubview:_view1];
        
        _sonView11 = [UIView new];
        [_view1 addSubview:_sonView11];
        
        _sonView12 = [UIView new];
        [_view1 addSubview:_sonView12];
    }
    
    {
        _view1.backgroundColor = [UIColor yellowColor];
        _sonView11.backgroundColor = [UIColor greenColor];
        _sonView12.backgroundColor = [UIColor orangeColor];
    }
    
    {
        
        [_view1 removeFromSuperview];
//        这里的view被删除了之后，就会出现问题 （也就是它的父的view不存在了，怎么去对齐呢？）

        [_sonView11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_sonView01.mas_bottom).offset(200);
            make.height.width.mas_equalTo(200);
            make.left.equalTo(_view0);
        }];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
