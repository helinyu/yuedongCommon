//
//  YDTestViewController.m
//  TestCoreText
//
//  Created by mac on 5/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest12ViewController.h"
#import <YYAsyncLayer.h>
#import "YDTest12View.h"
#import "YDTest12Layer.h"
#import "YDAction.h"

@interface YDTest12ViewController ()<CALayerDelegate,YYAsyncLayerDelegate>

@property (nonatomic, strong) YYAsyncLayer *asyncLayer;
@property (nonatomic, strong) CALayer *originLayer;

@property (nonatomic, strong) YDTest12View *test12View;

@property (nonatomic, strong) YDTest12Layer *test12Layer;

@end

@implementation YDTest12ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn1];
    btn1.frame = CGRectMake(0, 64, 100, 40);
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onTapbtn1) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor blueColor];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn2];
    btn2.frame = CGRectMake(100, 64, 100, 40);
    [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onTapbtn2) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor redColor];
  
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn3];
    btn3.frame = CGRectMake(200, 64, 100, 40);
    [btn3 setTitle:@"btn3" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(onTapbtn3) forControlEvents:UIControlEventTouchUpInside];
    btn3.backgroundColor = [UIColor purpleColor];

}

- (void)onTapbtn1 {
    _originLayer = [CALayer new];
    _originLayer.backgroundColor = [UIColor blueColor].CGColor;
    _originLayer.frame = CGRectMake(0, 200, 100, 80);
    _originLayer.delegate = self;
    [self.view.layer addSublayer:_originLayer];
}

- (void)onTapbtn2 {
    _asyncLayer = [YYAsyncLayer new];
//    _asyncLayer.delegate = self;
    _asyncLayer.backgroundColor = [UIColor redColor].CGColor;
    _asyncLayer.frame = CGRectMake(0, 200, 100, 80);
    [self.view.layer addSublayer:_asyncLayer];
}

- (void)onTapbtn3 {
    _test12Layer = [YDTest12Layer new];
    _test12Layer.frame = CGRectMake(0, 300, 100, 40);
    _test12Layer.backgroundColor = [UIColor purpleColor].CGColor;
    _test12Layer.delegate = self;
    [self.view.layer addSublayer:_test12Layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//
//- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
//    YYAsyncLayerDisplayTask *task = [YYAsyncLayerDisplayTask new];
//    NSLog(@"new play task");
//    task.willDisplay = ^(CALayer * _Nonnull layer) {
//        NSLog(@"will display");
//    };
//    task.display = ^(CGContextRef  _Nonnull context, CGSize size, BOOL (^ _Nonnull isCancelled)(void)) {
//        NSLog(@"display");
//    };
//    task.didDisplay = ^(CALayer * _Nonnull layer, BOOL finished) {
//        NSLog(@"did display");
//    };
//    return task;
//}
//
//- (void)displayLayer:(CALayer *)layer {
//    NSLog(@"displayLayer");
//}
//
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    NSLog(@"drawLayer:inContext");
//}
//
//- (void)layerWillDraw:(CALayer *)layer  {
//    NSLog(@"layerWillDraw");
//}

//- (void)layoutSublayersOfLayer:(CALayer *)layer {
////    [self.originLayer layoutSublayersOfLayer:layer];
//    NSLog(@"layoutSublayersOfLayer");
//}

//- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
//    NSLog(@"layer :%@, event:%@",layer, event);
//    YDAction *action = [YDAction new]; // 返回的动画（一般）
//    if (CGRectContainsPoint(self.originLayer.frame, layer.position)) {
//        NSLog(@"inside");
//    }
//    else {
//        NSLog(@"outside");
//    }
//    return action;
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touch began:%@, event:%@",touches,event);
//}

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    NSLog(@"layer ");
    return nil;
}

@end
