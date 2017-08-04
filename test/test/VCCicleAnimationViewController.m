//
//  VCCicleAnimationViewController.m
//  test
//
//  Created by felix on 2017/5/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "VCCicleAnimationViewController.h"
#import "MASExampleUpdateView.h"

@interface VCCicleAnimationViewController ()
@property (nonatomic, strong) MASExampleUpdateView *subView;
@end

@implementation VCCicleAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.subView.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview:self.subView];
    
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
