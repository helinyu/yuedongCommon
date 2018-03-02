//
//  YDTextImageViewController.m
//  TestCoreText
//
//  Created by mac on 1/3/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTextImageViewController.h"
#import <DTCoreText.h>

@interface YDTextImageViewController ()

@property (nonatomic, strong) DTAttributedLabel *subLabel;
@property (nonatomic, strong) UILabel *label;

@end

@implementation YDTextImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self test1];
//    [self test2];
//    [self test3];
    [self test4];
    [self test5];
}

- (void)test5 {
    _label = [UILabel new];
    [self.view addSubview:_label];
    _label.frame = CGRectMake(100, 100.f, 200.f, 200.f);
    _label.attributedText = [[NSAttributedString alloc] initWithString:@"hello" attributes:@{NSBackgroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSObliquenessAttributeName:@(0.5)}];
}

- (void)test4 {
    _subLabel = [DTAttributedLabel new];
    [self.view addSubview:_subLabel];
    _subLabel.frame = CGRectMake(200, 200, 200.f, 200.f);
    _subLabel.attributedString =[[NSAttributedString alloc] initWithString:@"hello" attributes:@{NSBackgroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSObliquenessAttributeName:@(0.5)}];
}

- (void)test3 {
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 200, 300, 30)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"forContro将label的字体设置为斜体";
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-15 * (CGFloat)M_PI / 180), 1, 0, 0);
    label.transform = matrix;
    [self.view addSubview:label];
}

- (void)test2 {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 200, 300, 30)];
//    label.text = @"forControlEvents:UIControlEven";
    label.text = @"你好";
    label.font = [UIFont italicSystemFontOfSize:20];//设置字体为斜体
    [self.view addSubview:label];
}

- (void)test1 {
//    本地加载图片
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resourcePath = [bundle resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"Snip20180212_2.png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath]; // 不缓存（系统+沙盒）
    UIImage *image1 =  [UIImage imageNamed:@"Snip20180212_2.png"]; // 缓存（系统）
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100.f, 100.f, 100.f, 100.f)];
    imageView.image = image;
    [self.view addSubview:imageView];
}

- (void)test0 {
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
