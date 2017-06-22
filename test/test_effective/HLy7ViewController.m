

//
//  HLy7ViewController.m
//  test
//
//  Created by felix on 2017/6/22.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLy7ViewController.h"

@interface HLy7ViewController ()

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@end

@implementation HLy7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *aaa = @"aaa";
    NSLog(@"aaa : %p",aaa);
    NSLog(@"_firstName  : %p",_firstName);

//    [self test0:aaa];
    [self test1:aaa];
}


- (void)test0:(NSString *)firstName {
    NSLog(@"before firstname : %p",firstName);
    NSLog(@"before _firstName : %p",_firstName);
    _firstName = firstName;
    NSString *a  = firstName;
    NSString *b = _firstName;
    a =@"1";
    firstName = @"3";
    NSLog(@"after firstname : %p",firstName);
    NSLog(@"after _firstName : %p",_firstName);
    
//    string 一旦经过值发生了改变，就会发生拷贝,也就是地址发生了改变，如果没有改变的，还是指向的是同一个地址；
    
}

- (void)test1:(NSString *)firstName {
    NSLog(@"before firstname : %p",firstName);
    NSLog(@"before _firstName : %p",_firstName);
    self.firstName = firstName;
//    NSString *a  = firstName;
//    NSString *b = _firstName;
//    a =@"1";
    firstName = @"3";
    NSLog(@"after firstname : %p",firstName);
    NSLog(@"after _firstName : %p",self.firstName);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
