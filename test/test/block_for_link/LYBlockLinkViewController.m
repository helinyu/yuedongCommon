//
//  LYBlockLinkViewController.m
//  test
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "LYBlockLinkViewController.h"
#import "LYBlockPerson.h"
#import "LYBlockPerson2.h"

@interface LYBlockLinkViewController ()

@end

@implementation LYBlockLinkViewController


//这里的界面为什么会将上一个界面显示在这里呢？
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
//    这个是oc方法实现多个方法进行调用，若是要实现链式调用，应该怎么样进行处理？block是如何进行实现的？
//    LYBlockPerson *person = [LYBlockPerson new];
//    [[person study] run];

    LYBlockPerson2 *person2 = [LYBlockPerson2 new];
    person2.study(@"好好").run().study(@"haha");
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 50, 100, 100);
}

- (void)toAction:(UIButton *)sender {
    NSLog(@"sender ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
