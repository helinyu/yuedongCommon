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
    
    obj.blockName = [obj wholeNameWithLastName:@"yu" requestHandler:^NSString *{
        return @"he";
    }];
    NSLog(@"name : %@",obj.blockName(@"lin"));
    
    NSString *noneName = obj.linkNone;
    NSLog(@"none Name: %@",noneName);
    
    NSLog(@"link none : %@",obj.linkNoneR.linkNone);
//    NSLog(@"onne param : %@",obj.linkOneParam(@"hah")); // 出现错误，和参数有差别
    NSLog(@" one param s : %@",[obj linkOneParam:@"one param"]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
