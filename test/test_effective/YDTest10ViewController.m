//
//  YDTest10ViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/28.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDTest10ViewController.h"

@interface YDTest10ViewController ()

@property (nonatomic,strong) UILabel *aaa;

@property (nonatomic, strong) UILabel *pasteLabel;

@end

@implementation YDTest10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.aaa = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 20)];
    self.aaa.backgroundColor = [UIColor yellowColor];
    self.aaa.text = @"三掌柜666";
    //UILabel自身不能接收事件，需要开发者给它添加长按事件
    self.aaa.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPre:)];
    [self.aaa addGestureRecognizer:longPress];
    [self.view addSubview:self.aaa];
    
    self.pasteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 300, 20)];
    [self.view addSubview:self.pasteLabel];
    self.pasteLabel.backgroundColor = [UIColor redColor];

}
// 使label能够成为响应事件，为了能接收到事件（能成为第一响应者）
- (BOOL)canBecomeFirstResponder{
    return YES;
}
// 可以控制响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copy:));
}
//针对响应方法的实现，最主要的复制的两句代码
- (void)copy:(id)sender{
    //UIPasteboard：该类支持写入和读取数据，类似剪贴板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.aaa.text;
    
    self.pasteLabel.text = pasteBoard.string;
}

- (void)longPre:(UILongPressGestureRecognizer *)recognizer{
    [self becomeFirstResponder]; // 用于UIMenuController显示，缺一不可
    //UIMenuController：可以通过这个类实现点击内容，或者长按内容时展示出复制等选择的项，每个选项都是一个UIMenuItem对象
    UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.aaa.frame inView:self.aaa.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
