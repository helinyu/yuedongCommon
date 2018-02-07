//
//  YDTest16ViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/2/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest16ViewController.h"

@interface YDTest16ViewController ()

@end

@implementation YDTest16ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self test1];
//    [self test0];
}

// user semaphore
- (void)test1 {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//     下面是生成一个dispatch semaphore .
//    dispatch semaphore  的就似乎初始值设定为1
//    保证可访问NSMutableArray 类对象的线程
//    同时只能够1个
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    NSMutableArray *array = [NSMutableArray new];
    for (int i =0; i <10000; ++i) {
        dispatch_async(queue, ^{
            /*
             等待dispatch semaphore
             一直等待，知道dispatch semaphore的计数值达到大于等于1
             */
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            /*
             * 由于dispatch semaphore 的计数值达到大于等于1
             * 所以将dispatch semaphore 的计数值减去1
             * dispatch_semaphore_wait 函数执行返回
             *即为，执行大搜此时的dispatch semaphore 的技术值为0。
             * 由于可访问NSMutableArray 类对象的线程只有1个
             *因为，可安全的进行更新z
             */
            [array addObject:[NSNumber numberWithInteger:1]];
            /*
             * 排他控制处理结束， 所以通过dispatch_semaphore_signal 函数。将dispatch semaphore 的计数值加1.
             如果有通过dispatch_semaphore_wait 函数，等待dispatch semaphore 的计数值增加的线程，就由最先等的线程执行。
             */
            dispatch_semaphore_signal(semaphore);
        });
    }
//如果使用结束，需要如一下这样 ,释放dispatch semaphore
//    dispatch_release(semaphore); [ARC 中好像不用调用这个方法]
}

// not semephore
- (void)test0 {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSMutableArray *array = [NSMutableArray new];
    for (int i =0; i < 1000; ++i) {
        dispatch_async(queue, ^{
            [array addObject:[NSNumber numberWithInteger:i]];
        });
    }
    NSLog(@"array :%@",array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
