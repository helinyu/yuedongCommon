//
//  YDDispatchViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDDispatchViewController.h"

@interface YDDispatchViewController ()

@end

@implementation YDDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self test0];
}

- (void)test0 {
    NSArray *array = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_async(queue, ^{
//    放在主线程（当前）就会出现错误，这个一定不要放在当前的线程，一定异步到其他线程（应该是这样）
//        dispatch_apply([array count], dispatch_get_main_queue(), ^(size_t index) { 错误
//这个可以在主线程的，会执行完block里面的内容在进行你处理其他的；
//    网络请求上都是用group，是否也可以使用这个？有待验证
    dispatch_apply([array count], queue, ^(size_t index) {
            NSLog(@" %zu: %@",index, [array objectAtIndex:index]);
        });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"asy queue");
    });
//    });
    NSLog(@"main done ouitside");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
