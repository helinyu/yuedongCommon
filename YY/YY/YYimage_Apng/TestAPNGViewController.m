//
//  TestAPNGViewController.m
//  YY
//
//  Created by Aka on 2017/8/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "TestAPNGViewController.h"
#import "YYImage.h"

@interface TestAPNGViewController ()

@end


//APNG格式的图片，和png图片一样，不过质量好很多，可以用来展示大图

@implementation TestAPNGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 加载图片
    YYImage * image = [YYImage imageNamed:@"pia"];
    // 类似系统的UIImageView(这里作者重写用于显示gif、WebP和APNG格式图片)
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 70, 300, 300);
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
