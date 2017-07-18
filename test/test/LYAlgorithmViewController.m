
//
//  LYAlgorithmViewController.m
//  test
//
//  Created by Aka on 2017/7/17.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "LYAlgorithmViewController.h"

@interface LYAlgorithmViewController ()

@end

@implementation LYAlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<NSNumber *> *souces = @[@50,@26,@38,@80,@70,@90,@8,@30,@40,@20];

//    [self testForAg];
//    [self testForQuickSort];
    [self bubbleSort:[souces mutableCopy] With:souces.count];
}

- (void)bubbleSort:(NSMutableArray<NSNumber *> *)souce With:(NSInteger) n {
    for (NSInteger index =0; index < n-1; index++) {
        BOOL flag = NO;
        for (NSInteger subIndex =n-1; subIndex > index; subIndex--) {
            
            if (souce[subIndex-1].integerValue > souce[subIndex].integerValue) {
                NSNumber *swap = souce[subIndex -1];
                NSNumber *swap1 = souce[subIndex];
                souce[subIndex -1] = swap1;
                souce[subIndex] = swap;
                flag = YES;
            }
        }
        if (!flag) {
            break; // 表示这一次就已经排序好了
        }
    }
    NSLog(@"souce : %@",souce);
}

- (void)testForQuickSort {

    
}

- (void)testForAg {
    
    NSArray<NSNumber *> *source = @[
                                    //                        @1,@3,@(-3)
                                    @4,@3,@2,@5,@1,@1
                                    ];
    NSNumber *left = source[0];
    NSNumber *right =  source[source.count -1];
    NSNumber *max = source[0];
    for (NSInteger index = 0; index < source.count; index++) {
        if (source[index].integerValue > max.integerValue) {
            max = source[index];
        }
    }
    NSInteger result = MAX((max.integerValue-left.integerValue), (max.integerValue-right.integerValue));
    NSLog(@"result is : %ld",(long)result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
