//
//  YDNSNullViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/23.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDNSNullViewController.h"

@interface YDNSNullViewController ()

@end

@implementation YDNSNullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test0];

}

- (void)test0 {
    NSArray *arrs = @[@"asdfjka",[NSNull null],@"gaga"];
    NSLog(@"arrs length : %lu",(unsigned long)arrs.count);
    for (NSInteger index =0; index< arrs.count; index++) {
        NSLog(@"index :%ld, content :%@",(long)index,arrs[index]);
        if (arrs[index] && arrs[index] != [NSNull null]) {
            NSLog(@"has content :%@",arrs[index]);
        }
        else {
            NSLog(@"no has content :%@",arrs[index]);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
