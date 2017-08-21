//
//  ViewController.m
//  ivar
//
//  Created by Aka on 2017/8/19.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p = [Person new];
    p.name1 = @"name1";// 说明有关的内容是name1 （name0 是不能够访问的）
//    【setter 方法】
//    我们推断出，@property其实也带有接口属性，也就是能够被外部对象访问
    NSLog(@"name1: %@",p.name1);
//    [getter 方法];
//    @property中声明的属性是会自动生成setter和getter的方法
    
//    获取成员列表
    NSLog(@"p 's name 3 ; %@",p.name3);
    
    p.i

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
