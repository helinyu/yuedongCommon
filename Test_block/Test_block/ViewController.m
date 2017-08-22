//
//  ViewController.m
//  Test_block
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test0];
    
}

- (void)test0 {
    YDObject *obj= [YDObject new];
    
//    这样的一个函数，传递进去之后，经过了规则进行处理之后，将得到的结果在进行处理，
    NSString *name = [obj wholeNameWithName:@"linyu" requestHandler:^NSString *{
        return @"he";
    }];
    NSLog(@"name : %@",name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
