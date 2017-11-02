//
//  YDPhotoTakenViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/2.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDPhotoTakenViewController.h"
#import "CameraSessionView.h"
#import "Masonry.h"
#import "CameraShutterButton.h"

@interface YDPhotoTakenViewController ()<CACameraSessionDelegate>

@property (nonatomic, strong) CameraSessionView *sessionView;

@property (nonatomic, strong) CameraShutterButton *takenBtn;

@end

@implementation YDPhotoTakenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.view.backgroundColor = [UIColor grayColor];

    _sessionView = [CameraSessionView new];
    [self.view addSubview:_sessionView];
    _sessionView.delegate = self;
    [_sessionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    NSLog(@"直接进入拍照会话页面");
    
    _takenBtn = [CameraShutterButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_takenBtn];
    [_takenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20.f);
        make.centerX.equalTo(self.view);
    }];
    [_takenBtn setTitle:@"拍照" forState:UIControlStateNormal];
    _takenBtn.backgroundColor = [UIColor yellowColor];
    [_takenBtn addTarget:self action:@selector(onPhotoTaken:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didCaptureImage:(UIImage *)image {
    NSLog(@"获取到拍照的图片");
//    可以通过获取相册中的最新的一张图片
}
- (void)didCaptureImageWithData:(NSData *)imageData {
    NSLog(@"获取到拍照图片的数据J");
}

- (void)onPhotoTaken:(UIButton *)sender {
    [_sessionView inputManager:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
