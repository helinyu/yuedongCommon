//
//  TestWebPViewController.m
//  YY
//
//  Created by Aka on 2017/8/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "TestWebPViewController.h"
#import "YYImage.h"

//    使用Uiimage+ UIIMageView就不可以实现了这个功能了

@interface TestWebPViewController ()

@end

//架子啊webp格式图片
//这种格式得图片暂时没有下载到（默认通过）

@implementation TestWebPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载图片
    YYImage * image = [YYImage imageNamed:@"wall-e"];
    // 类似系统的UIImageView(这里作者重写用于显示gif、WebP和APNG格式图片)
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 70, 300, 300);
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
