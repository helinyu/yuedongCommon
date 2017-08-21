//
//  ViewController.m
//  ivar
//
//  Created by Aka on 2017/8/19.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "NSObject+YDClass.h"

@interface ViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
    [self test2];
    [self test3];
}

- (void)test2 {
    NSArray *methods = MethodsOfClass([Person class]);
    NSLog(@"methods : %@",methods);
}

- (void)test3 {
    NSArray *methods = MethodsOfClassFilter([Person class], @"test");
    NSLog(@"methods : %@",methods);
}

- (void)test1 {
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList([Person class], &methodCount);
    if (methods) {
        for (unsigned int i =0; i <methodCount; i++) {
            //            NSLog("methods :%@" + methods[i]);
            SEL sel = method_getName(methods[i]);
            const char *name = sel_getName(sel);
            if (name) {
                NSString *nameString = [NSString stringWithUTF8String:name];
                NSLog(@"name string : %@",nameString);
            }
        }
    }
}

- (void)test0 {
    Person *p = [Person new];
    p.name1 = @"name1";// 说明有关的内容是name1 （name0 是不能够访问的）
    //    【setter 方法】
    //    我们推断出，@property其实也带有接口属性，也就是能够被外部对象访问
    NSLog(@"name1: %@",p.name1);
    //    [getter 方法];
    //    @property中声明的属性是会自动生成setter和getter的方法
    
    //    获取成员列表
    NSLog(@"p 's name 3 : %@",p.name3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
