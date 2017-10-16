//
//  ViewController.m
//  TestProject
//
//  Created by Aka on 2017/9/27.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "View+MASAdditions.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 100, 200, 300)];
//    [self.view addSubview:_scrollView];
//    _scrollView.backgroundColor = [UIColor yellowColor];
//        _scrollView.contentSize = CGSizeMake(200, 400);
//        _scrollView.contentInset = UIEdgeInsetsMake(30, -20, 20, 20);
////     insets这个应该是以左上角为基准
//
//    //    _scrollView.contentOffset = CGPointMake(50, 50);
//    //contentsize 或者inset 上的内容都会影响到大小
//
//    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 80)];
//    [_scrollView addSubview:subView];
//    subView.backgroundColor = [UIColor redColor];
//
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
//    [_scrollView addSubview:imgView];
//    imgView.image = [UIImage imageNamed:@"Snip20170927_1.png"];
//
//    NSLog(@"content size width:%f, height: %f",_scrollView.contentSize.width,_scrollView.contentSize.height);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"设置图片" forState:UIControlStateNormal];
    [btn sizeToFit];

    btn.titleLabel.backgroundColor = [UIColor greenColor];
    btn.imageView.backgroundColor = [UIColor purpleColor];
    [btn setImage:[UIImage imageNamed:@"icon_origin_circle_all"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSetClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 200, 200, 300);
    [self.view addSubview:btn];
//    btn.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 30, 30);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.titleLabel.bounds.size.width, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width+btn.imageView.bounds.size.width, 0, -btn.imageView.bounds.size.width);
    btn.tintColor = [UIColor yellowColor];
    
    //    @property(nonatomic)          UIEdgeInsets contentEdgeInsets UI_APPEARANCE_SELECTOR; // default is UIEdgeInsetsZero. On tvOS 10 or later, default is nonzero except for custom buttons.
    //    @property(nonatomic)          UIEdgeInsets titleEdgeInsets;                // default is UIEdgeInsetsZero
    //    @property(nonatomic)          BOOL         reversesTitleShadowWhenHighlighted; // default is NO. if YES, shadow reverses to shift between engrave and emboss appearance
    //    @property(nonatomic)          UIEdgeInsets imageEdgeInsets;
}

- (void)onSetClick:(id)sender {
    NSLog(@"点击了按钮");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
