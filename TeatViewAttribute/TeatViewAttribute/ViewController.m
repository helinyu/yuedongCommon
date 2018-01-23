//
//  ViewController.m
//  TeatViewAttribute
//
//  Created by mac on 23/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "GHView.h"
#import "GHLabel.h"
#import "GHCustomView.h"

@interface ViewController ()

@property (nonatomic, strong) GHView *subView0;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) GHLabel *subLabel;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) GHCustomView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
}

- (void)test1 {
    
    _customView = [[GHCustomView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
    [self.view addSubview:_customView];
//    应该是要添加对应的内容进入
    _customView.backgroundColor = [UIColor yellowColor];
}

- (void)test0 {
    //    _subView0 = [[GHView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    //    _subView0.backgroundColor = [UIColor yellowColor];
    //    [self.view addSubview:_subView0]; //invalidateIntrinsicContentSize
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_btn];
    _btn.backgroundColor = [UIColor redColor];
    [_btn setTitle:@"碘酒" forState:UIControlStateNormal];
    _btn.frame = CGRectMake(0, 200, 100, 30);
    [_btn addTarget:self action:@selector(onTapClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _subLabel = [[GHLabel alloc] initWithFrame:CGRectMake(0, 100, 100, 30)];
    _subLabel.text = @"23"; // 设置文案的时候回调用invalidateIntrinsicContentSize
    [_subLabel sizeToFit];
    [self.view addSubview:_subLabel]; // invalidateIntrinsicContentSize
}

- (void)onTapClick:(id)sender {
//    CGSize contentSize =_subView0.frame.size;
//    CGSize size = _subView0.intrinsicContentSize;
//
//    if (_subView0.frame.size.height == 100) {
//        _subView0.frame = CGRectMake(0, 100, 50,50);
//    }else {
//        _subView0.frame = CGRectMake(0, 100, 100, 100);
//    }
//    CGSize contentSize1 =_subView0.frame.size;
//    CGSize size1 = _subView0.intrinsicContentSize;
//    NSLog(@"size ; %f",size.height);
    
    CGSize contentSize = _subLabel.intrinsicContentSize;
    CGSize boundsize = _subLabel.bounds.size;
    CGSize framesize = _subLabel.frame.size;
    if ([_subLabel.text isEqualToString:@"kadsdjfks"]) {
        _subLabel.text = @"23";
    }else {
        _subLabel.text =@"kadsdjfks" ;
    }
    [_subLabel sizeToFit];

    CGSize contentSize1 = _subLabel.intrinsicContentSize;
    CGSize boundsize1 = _subLabel.bounds.size;
    CGSize framesize11 = _subLabel.frame.size;
    
    
    
    NSLog(@"size");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
