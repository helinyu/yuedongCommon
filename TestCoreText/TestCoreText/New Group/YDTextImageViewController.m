//
//  YDTextImageViewController.m
//  TestCoreText
//
//  Created by mac on 1/3/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTextImageViewController.h"

@interface YDTextImageViewController ()

@end

@implementation YDTextImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view0  = [[UIView alloc] initWithFrame:CGRectMake(100.f, 100.f, 200.f, 200.f)];
    [self.view addSubview:view0];
    view0.backgroundColor = [UIColor yellowColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [view0 addSubview:view1];
    view1.backgroundColor = [UIColor redColor];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Snip20180212_2.png"]];
    imgView2.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
    [view0 addSubview:imgView2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.f, 50.f, 50.f, 50.f)];
    [view0 addSubview:label];
    label.text = @"sdfjl";
    
    UIImage *sonImg1 = [self createShareUploadImageWithImg:view1 rect:view0.bounds];
    NSLog(@"son img1 :%@",sonImg1);
}

// 有关的截图，可以完全使用yy分类
- (UIImage *)createShareUploadImageWithImg:(UIView *)view rect:(CGRect)rect {
    CGFloat pixel = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, pixel);//2倍像素
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGSize size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(pixel, pixel));
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0.f, 0.f, rect.size.width, rect.size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
