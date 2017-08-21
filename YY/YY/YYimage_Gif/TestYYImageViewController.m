//
//  TestYYImageViewController.m
//  YY
//
//  Created by Aka on 2017/8/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "TestYYImageViewController.h"
#import "YYImage.h"

@interface TestYYImageViewController ()

@end

@implementation TestYYImageViewController

// 这里很简单的实现了gif的图片的效果（原来应该是不可以实现的）
//看了这个内容，就是重写了UIImage
// ImageView -继承了UIImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    YYImage *image = [YYImage imageNamed:@"test0.gif"];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 79, 300, 300);
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
