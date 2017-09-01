//
//  YDBaseSliderController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDBaseSliderController.h"

@interface YDBaseSliderController ()

@property (nonatomic, strong) UISlider *slider;

@end

@implementation YDBaseSliderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *addSliderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addSliderBtn setTitle:@"增加slie 0.1长度" forState:UIControlStateNormal];
    [addSliderBtn addTarget:self action:@selector(onSliderAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSliderBtn];
    addSliderBtn.frame = CGRectMake(100, 100, 200, 30);
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 200, 300, 10)];
    [_slider setValue:0.5 animated:YES];
    [_slider addTarget:self action:@selector(onSliderClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    _slider.backgroundColor = [UIColor yellowColor];
    _slider.minimumTrackTintColor = [UIColor greenColor];
    _slider.maximumTrackTintColor = [UIColor redColor];
}

- (void)onSliderClick:(UIControlEvents)event {
    NSLog(@"event : %lu",(unsigned long)event);
    NSLog(@"_slieder : %f",_slider.value);
}

- (void)onSliderAdd {
    NSLog(@"slider ");
    [_slider setValue:(_slider.value + 0.1) animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"beginTrackingWithTouch");
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"continueTrackingWithTouch");
    return YES;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"endTrackingWithTouch");
}

- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    NSLog(@"cancelTrackingWithEvent");
}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    NSLog(@"addTarget:forControlEvents");
}

- (void)removeTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents {
    NSLog(@"removeTarget:forControlEvents");
}

//slider ——> control -- > uiview
//可以进行重写

@end
