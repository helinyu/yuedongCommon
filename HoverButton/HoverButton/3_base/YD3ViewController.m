//
//  YD3ViewController.m
//  HoverButton
//
//  Created by Aka on 2017/12/26.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YD3ViewController.h"

@interface YD3ViewController ()

@end

@implementation YD3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self syncAction];

}

- (void)syncAction {
    dispatch_group_t group =dispatch_group_create();
    dispatch_queue_t globalQueue=dispatch_get_global_queue(0, 0);
    dispatch_group_enter(group);
    
    //模拟多线程耗时操作
    dispatch_group_async(group, globalQueue, ^{
        sleep(3);
        NSLog(@"%@---block1结束。。。",[NSThread currentThread]);
        dispatch_group_leave(group);

    });
    NSLog(@"%@---1结束。。。",[NSThread currentThread]);
    
    //模拟多线程耗时操作
    
    dispatch_group_t group1 = dispatch_group_create();
    dispatch_group_enter(group1);
    dispatch_group_async(group1, dispatch_get_global_queue(0,0), ^{
        sleep(3);
        NSLog(@"%@---block2结束。。。",[NSThread currentThread]);
        dispatch_group_leave(group1);
    });
    NSLog(@"%@---2结束。。。",[NSThread currentThread]);
    
    dispatch_async(globalQueue, ^{
        sleep(3);
        NSLog(@"%@---block3结束。。。",[NSThread currentThread]);
    });
    NSLog(@"%@---3结束。。。",[NSThread currentThread]);
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@---全部结束。。。",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group1, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@1---全部结束。。。",[NSThread currentThread]);
    });
    
//     总线程上有任务的时候，如果没有运行这个leave
//        的操作的时候， 是否会有问题？？ 应该只是针对这个group吧？
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
