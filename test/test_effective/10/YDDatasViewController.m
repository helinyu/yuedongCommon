//
//  YDDatasViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/9.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDDatasViewController.h"

@interface YDDatasViewController ()

@end

@implementation YDDatasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *datas = @[@1,@2,@3];
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index :%ld, index:%ld , *stop :%d",idx, [obj integerValue],*stop);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
