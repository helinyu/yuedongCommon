//
//  HLYPropertyViewController.m
//  test
//
//  Created by felix on 2017/6/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYPropertyViewController.h"
#import "CustomObj.h"

@interface HLYPropertyViewController ()

@property (nonatomic, assign) CGFloat aProperty;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) CustomObj *dataObject;

@end

@implementation HLYPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.aProperty = 45;
    NSLog(@"a property : %f",self.aProperty);

}

- (void)setAProperty:(CGFloat)aProperty {
    NSLog(@"设置assin 类型的属性变量 a property");
}

- (CGFloat)aProperty {
    NSLog(@"get a property ");
//    return _aProperty;
    return self.aProperty + 3;
}

- (void)setName:(NSString *)name {
    NSLog(@"name: name setter ");
}

- (NSString *)name {
    NSLog(@"name getter ");
//    return _name;
    return @"ok";
}

//- (void)setObj:(CustomObj *)obj {
//    if (!_obj) {
//        _obj = [CustomObj new];
//    }
//    _obj.name = obj.name;
//    _obj.password = obj.name;
//}

- (void)setDataObject:(CustomObj *)dataObject {

}

//- (CustomObj *)dataObject {
//    return _dataObject;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}

#pragma warning -- 为什么我现在的设置就是不行呢？

@end
