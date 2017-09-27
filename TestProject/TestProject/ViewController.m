//
//  ViewController.m
//  TestProject
//
//  Created by Aka on 2017/9/27.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 100, 200, 300)];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor yellowColor];
        _scrollView.contentSize = CGSizeMake(200, 400);
        _scrollView.contentInset = UIEdgeInsetsMake(30, -20, 20, 20);
//     insets这个应该是以左上角为基准

    //    _scrollView.contentOffset = CGPointMake(50, 50);
    //contentsize 或者inset 上的内容都会影响到大小
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 80)];
    [_scrollView addSubview:subView];
    subView.backgroundColor = [UIColor redColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    [_scrollView addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"Snip20170927_1.png"];
    
    NSLog(@"content size width:%f, height: %f",_scrollView.contentSize.width,_scrollView.contentSize.height);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
