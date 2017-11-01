
//
//  YDZoomViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/1.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDZoomViewController.h"
#import "Masonry.h"
#import  "YDZoomView.h"
#import "YDCellZoomViewController.h"

@interface YDZoomViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) YDZoomView *zoomView;

@end

@implementation YDZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _zoomView = [YDZoomView new];
    [self.view addSubview:_zoomView];
    [_zoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _zoomView.zoomView.delegate = self;
    _zoomView.zoomView.minimumZoomScale = 1.f;
    _zoomView.zoomView.maximumZoomScale = 3.f;
    _zoomView.zoomView.bouncesZoom = YES;
    _zoomView.zoomView.scrollEnabled = YES;
    _zoomView.zoomView.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cell 上面的图片放大" style:UIBarButtonItemStyleDone target:self action:@selector(onAction:)];
}

- (void)onAction:(id)sender {
    [self.navigationController pushViewController:[YDCellZoomViewController new] animated:YES];
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _zoomView.imgView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2) {
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    
}

@end
