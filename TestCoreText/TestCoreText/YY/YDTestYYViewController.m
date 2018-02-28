
//
//  YDTestYYViewController.m
//  TestCoreText
//
//  Created by mac on 27/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTestYYViewController.h"
#import <Masonry.h>
#import <YYText.h>
#import <UIImageView+WebCache.h>
#import <UIView+WebCache.h>
#import <YYImage.h>

@interface YDTestYYViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *yyImageView;

@end

@implementation YDTestYYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [UIImageView new];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100.f);
        make.width.height.mas_equalTo(100.f);
    }];
    
    _yyImageView = [UIImageView new];
    [self.view addSubview:_yyImageView];
    [_yyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100.f);
        make.top.equalTo(self.view).offset(250.f);
        make.width.height.mas_equalTo(100.f);
    }];
    
    UIImage *placeHolderImage = [UIImage imageNamed:@"Snip20180212_2.png"];
    
    NSString *urlString = @"http://img.taopic.com/uploads/allimg/120727/201995-120HG1030762.jpg";
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *urlString1 = @"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png";
    NSURL *url1 = [NSURL URLWithString:urlString1];

//    [_imageView sd_setShowActivityIndicatorView:NO]; // 应该能够展示才对
    [_imageView sd_setImageWithURL:url1 placeholderImage:placeHolderImage options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"received size :%zd, expectedSize:%zd, targetUrl:%@",receivedSize,expectedSize, targetURL.absoluteString);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"image :%@, error:%@, cacheType:%zd, imageUrl:%@",image,error,cacheType,imageURL.absoluteString);
    }];
    
//    _yyImageView
}

@end
