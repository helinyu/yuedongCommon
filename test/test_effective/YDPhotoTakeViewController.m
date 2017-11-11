//
//  YDPhotoTakeViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDPhotoTakeViewController.h"
#import "YDPhotoTakenView.h"
#import "Masonry.h"

@interface YDPhotoTakeViewController ()

@property (nonatomic, strong) YDPhotoTakenView *photoTakenView;

@property (nonatomic, strong) UIButton *shuffterBtn;
@property (nonatomic, strong) UIButton *toggleBtn;

@property (nonatomic, strong) UIButton *toggleRunninBtn;
@property (nonatomic, strong) UIImageView *imagView;

@end

@implementation YDPhotoTakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _photoTakenView = [[YDPhotoTakenView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:_photoTakenView];
    _photoTakenView.backgroundColor = [UIColor yellowColor];
    
    _shuffterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_shuffterBtn];
    [_shuffterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
    }];
    [_shuffterBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [_shuffterBtn addTarget:self action:@selector(onTakeImg:) forControlEvents:UIControlEventTouchUpInside];
    
    _toggleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_toggleBtn];
    [_toggleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(_shuffterBtn.mas_right).offset(50);
    }];
    [_toggleBtn setTitle:@"切换" forState:UIControlStateNormal];
    [_toggleBtn addTarget:self action:@selector(onChangeTo:) forControlEvents:UIControlEventTouchUpInside];
    
    _imagView = [UIImageView new];
    [self.view addSubview:_imagView];
    [_imagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.width.height.mas_equalTo(200.f);
    }];
    _imagView.contentMode = UIViewContentModeScaleAspectFit;
    
    _toggleRunninBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_toggleRunninBtn];
    [_toggleRunninBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_toggleBtn.mas_right).offset(100);
        make.bottom.equalTo(self.view);
    }];
    [_toggleRunninBtn setTitle:@"停止" forState:UIControlStateNormal];
    [_toggleRunninBtn addTarget:self action:@selector(onStopTo:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)onTakeImg:(id)sender {
    [_photoTakenView takePhotoThen:^(NSData *imgData, UIImage *img) {
        UIImage *getIMg = img;
        NSLog(@"data :%@ , data lenth :%lu , imag :%@",imgData, (unsigned long)imgData.length, img);
        self.imagView.image = img;
    }];
}

- (void)onChangeTo:(id)sender {
    [_photoTakenView toggleCamera];
}

- (void)onStopTo:(id)sender {
    [_photoTakenView toggleRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
