//
//  ViewController.m
//  testVision
//
//  Created by Aka on 2017/7/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#import <Vision/Vision.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *startBtn;

@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) UIImageView *scene;

@end

static const NSInteger navBarH = 64.f;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    let vowels: [Character] = ["a", "e", "i", "o", "u"]

    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startBtn setTitle:@"获取图片" forState:UIControlStateNormal];
    [_startBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_startBtn];
    [_startBtn addTarget:self action:@selector(onStartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    _answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _answerLabel.text = @"answer";
    [self.view addSubview:_answerLabel];
    [_answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGRectGetWidth([UIScreen mainScreen].bounds));
//        make.top.equalTo(_scene.mas_bottom).offset(10); // 为什么这样写出现了错误？
        make.centerX.equalTo(self.view);
    }];
    
    _scene = [UIImageView new];
    _scene.image = [UIImage imageNamed:@"train_night"];
    [self.view addSubview:_scene];
    [_scene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(self.view);
        make.height.equalTo(_scene.mas_width);
    }];
    
    NSLog(@"vision version numer : %f",VNVisionVersionNumber);
//    2017-07-21 00:09:07.729708+0800 testVision[2121:76251] vision version numer : 1.000000  ？？当前版本是1.0 这个有什么作用？
//    VNRequest *requst = [[VNRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
//    }];
    
//    VNFaceLandmarks *faceLandMark = [VNFaceLandmarks alloc] ;

}

#pragma mark -- custom function
- (void)onStartClicked:(UIButton *)sender {
    NSLog(@"pick picture");
    UIImagePickerController *pvc = [UIImagePickerController new];
    pvc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pvc.delegate = self;
    [self presentViewController:pvc animated:YES completion:nil];
}

#pragma mark -- picker picture delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"info : %@",info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    if (img) {
        _scene.image = img;
    }else{
        NSLog(@"could not load the photos");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
