//
//  HLYResponderiewController.m
//  test_effective
//
//  Created by Aka on 2017/10/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYResponderiewController.h"
#import "YDCustomView.h"
#import <AVFoundation/AVFoundation.h>
#import "YDVideoView.h"
#import "Masonry.h"
#import "HLYView.h"
#import "HLY2View.h"

@interface HLYResponderiewController ()

@property (nonatomic, strong) YDCustomView *customView;

@property (nonatomic, strong) YDVideoView *videoView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation HLYResponderiewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    YDCustomView *customView = [[YDCustomView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:customView];
//    customView.backgroundColor = [UIColor orangeColor];
//    Class layClass = customView.layerClass;
//    NSLog(@"layer class : %@ ",layClass);
//    [self test0]; /// 实现layer上面的内容处理
//    [self test1];
//    [self test2];
//    [self test3];
    [self test4];
}

- (void)test4 {
    HLYView *view1 = [HLYView new];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(100);
    }];
    view1.backgroundColor = [UIColor yellowColor];
//    view1.clipsToBounds = NO;
    
    HLY2View *view2 = [HLY2View new];
    [view1 addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(view1).offset(50);
        make.width.height.mas_equalTo(100);
    }];
    view2.backgroundColor = [UIColor greenColor];
}

- (void)test3 {
//    实现hittest的使用
    YDCustomView *view1 = [YDCustomView new];
    [self.view addSubview:view1];
    view1.backgroundColor = [UIColor yellowColor];
    view1.frame = CGRectMake(100, 100, 100, 100);
    UITapGestureRecognizer *tap1 =[UITapGestureRecognizer new];
    [view1 addGestureRecognizer:tap1];
    [tap1 addTarget:self action:@selector(onTap1:)];
//    view1.userInteractionEnabled = NO; //. default yes ,
    
    YDCustomView *view2 = [YDCustomView new];
    [view1 addSubview:view2];
    view2.frame = CGRectMake(0, 50, 150, 150);
    view2.backgroundColor = [UIColor greenColor];
    view2.alpha = 0.5;
//    view2.userInteractionEnabled = NO; //. default yes ,
    UITapGestureRecognizer *tap2 =[UITapGestureRecognizer new];
    [view2 addGestureRecognizer:tap2];
    [tap2 addTarget:self action:@selector(onTap2:)];
}

- (void)test2 {
    NSLog(@"测试子view 超出父view的部分");
    
    UIView *view1 = [UIView new];
    [self.view addSubview:view1];
    view1.backgroundColor = [UIColor yellowColor];
    view1.frame = CGRectMake(100, 100, 100, 100);
    UITapGestureRecognizer *tap1 =[UITapGestureRecognizer new];
    [view1 addGestureRecognizer:tap1];
    [tap1 addTarget:self action:@selector(onTap1:)];
    view1.userInteractionEnabled = NO; //. default yes ,

    
    UIView *view2 = [UIView new];
    [view1 addSubview:view2];
    view2.frame = CGRectMake(0, 50, 150, 150);
    view2.backgroundColor = [UIColor greenColor];
    view2.alpha = 0.5;
//    view2.userInteractionEnabled = NO; //. default yes ,
//    UITapGestureRecognizer *tap2 =[UITapGestureRecognizer new];
//    [view2 addGestureRecognizer:tap2];
//    [tap2 addTarget:self action:@selector(onTap2:)];
    
/*
 得出结果如下：
 1、 设置为NO，view2 去掉tap的手势之后，点击view1 和view2 重叠部分就会显示view1 的输出
 2、如果view1 加上的tap之后，view1 就变成了最适合处理的对象了
 3、在目前，clickTobound = NO 的时候，这个时候，点击超出父view的地方是没有响应的，这个时候，就可以使用hitTest，重写这个方法精心让它可以相应；
 4、 不管view2 userInteractionEnabled 的值是yes，还是NO，只要view1 是yes，都是点击重叠的部分view1 都是可以处理的，但是它们原理应该不同，设置为yes的时候，应该是让父view处理，设置为NO的时候，直接点击的是View1 ，而view2 没有被点击到。
 5、如果view1 的 userInteractionEnabled为NO，(view默认都是yes）,这个时候，不管是view1还是view2 都是不响应的；view1 终端了响应链的传递。
 
 */
}
- (void)onTap1:(id)sender {
    NSLog(@"tap 1");
}
- (void)onTap2:(id)sender {
    NSLog(@"tap view 2");
}

- (void)test1 {
    _customView = [YDCustomView new];
    [self.view addSubview:_customView];
    [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(80);
    }];
    _customView.backgroundColor = [UIColor yellowColor];
}

//测试一个UIView上面的layer进行自定义
// 这里主要是测view 上放第一个layer的layerClass的方法

- (void)test0 {
    _videoView = [YDVideoView new];
    [self.view addSubview:_videoView];
    
    [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(100.f);
    }];
    _videoView.backgroundColor = [UIColor yellowColor];
    
    Class cls = [YDVideoView layerClass];
    Class cls2 = [YDCustomView layerClass];
    NSLog(@"clas ：%@",cls);
    NSLog(@"clas ：%@",cls2);
    
    _player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://192.168.11.127:8000/movie/test2.mp4"]];
    AVPlayerLayer *playerLayer = (AVPlayerLayer *)_videoView.layer;
    playerLayer.player = _player;
//    AVPlayerLayer *playerLayer = [AVPlayerLayer new];
//    playerLayer.frame = CGRectMake(0, 0, 100, 100);
//    [self.view.layer addSublayer:playerLayer];
    [_player play];

//     输出的结果如下
//    2017-10-19 17:30:52.720173+0800 test_effective[21441:3129820] clas ：AVPlayerLayer
//    2017-10-19 17:30:57.263448+0800 test_effective[21441:3129820] clas ：CALayer

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
