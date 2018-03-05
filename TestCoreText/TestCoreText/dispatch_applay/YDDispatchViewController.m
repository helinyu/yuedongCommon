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
    
    [self test0];
}

- (void)test0 {
    NSArray *array = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13];
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_apply([array count], queue, ^(size_t index) {
            NSLog(@" %zu: %@",index, [array objectAtIndex:index]);
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"asy queue");
        });
    });
    NSLog(@"main done ouitside");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
