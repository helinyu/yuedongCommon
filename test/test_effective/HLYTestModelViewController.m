//
//  HLYTestModelViewController.m
//  test_effective
//
//  Created by Aka on 2017/8/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYTestModelViewController.h"
#import "Son.h"
#import "YYKit.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface HLYTestModelViewController ()

@end

@implementation HLYTestModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    Son *son = [Son new];
    son.name = @"kask";
    son.age = @(19);
    son.UUID = [CBUUID UUIDWithString:@"F000FFC0-0451-4000-B000-000000000000"];
//    NSDictionary *datas = [son yy_modelToJSONObject];
//    NSLog(@"son dictionay : %@",datas);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
