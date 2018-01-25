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

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
    
//    [self test
    
}

- (void)test2 {
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_btn];
    _btn.backgroundColor = [UIColor redColor];
    [_btn setTitle:@"点击" forState:UIControlStateNormal];
    _btn.frame = CGRectMake(0, 64, 100, 30);
    [_btn addTarget:self action:@selector(onTapClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _imgView = [UIImageView new];
    [self.view addSubview:_imgView];
    self.view.backgroundColor = [UIColor yellowColor];
    _imgView.image = [UIImage imageNamed:@"Snip20180125_1.png"];
    _imgView.frame = CGRectMake(100, 100, 200, 100);
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
    
//    CGSize contentSize = _subLabel.intrinsicContentSize;
//    CGSize boundsize = _subLabel.bounds.size;
//    CGSize framesize = _subLabel.frame.size;
//    if ([_subLabel.text isEqualToString:@"kadsdjfks"]) {
//        _subLabel.text = @"23";
//    }else {
//        _subLabel.text =@"kadsdjfks" ;
//    }
//    [_subLabel sizeToFit];
//
//    CGSize contentSize1 = _subLabel.intrinsicContentSize;
//    CGSize boundsize1 = _subLabel.bounds.size;
//    CGSize framesize11 = _subLabel.frame.size;
    
    [self onTest2];
    
    NSLog(@"size");
}

- (void)onTest2 {
    
//     下右 移动100px
//    _imgView.transform = CGAffineTransformIdentity; // 默认是不变的
//    _imgView.transform = CGAffineTransformMakeTranslation(100.f, 100.f); // 像右、下移动了100.f     t' = [ 1 0 0 1 100.f 100.f ] */ frame 没有变化，还是原来的大小 （所以，平移之后再进行平移，是回到原来的位置进行平移）
//    _imgView.transform = CGAffineTransformMakeTranslation(0.f, 50); // 像右、下移动了100.f     t' = [ 1 0 0 1 100.f 100.f ] */ frame 没有变化，还是原来的大小 （所以，平移之后再进行平移，是回到原来的位置进行平移）

    //     x/y 轴线上的缩放 （）
//    _imgView.transform = CGAffineTransformMakeScale(0.5, 3);
//     注意这些变换都是只能够执行一个（后面的会被前面的覆盖掉）
    

    CGAffineTransform rotate =CGAffineTransformMakeRotation(M_PI_2);
    CGAffineTransform scale = CGAffineTransformMakeScale(0.5, 3);
    //     旋转 （角度）
//    _imgView.transform = rotate;
    
//    BOOL flag = CGAffineTransformIsIdentity(CGAffineTransformIdentity);
//  NSLog(@"falg :%zd",flag);
    
    CGAffineTransform firstTrans =   CGAffineTransformMakeTranslation(100.f, 100.f);
//    CGAffineTransform secondTrans = CGAffineTransformTranslate(firstTrans,100,100);
//    CGAffineTransform invertTrans = CGAffineTransformInvert(secondTrans);
//   CGAffineTransform concatTrans =
//    _imgView.transform = CGAffineTransformConcat(rotate,scale); //两个效果
//    CGAffineTransformEqualToTransform
    
   CGPoint point = CGPointApplyAffineTransform(_imgView.center, firstTrans);
//     变换之后的位置 (获取属性)
   CGRect rect = CGRectApplyAffineTransform(_imgView.frame, firstTrans);
    
    NSLog(@"falg :");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
