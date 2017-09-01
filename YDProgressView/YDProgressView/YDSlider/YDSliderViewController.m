
//
//  YDSliderViewController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDSliderViewController.h"
#import "YDAudioControlPannelMgr.h"

@interface YDSliderViewController ()

@end

@implementation YDSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    YDAudioControlPannelMgr *mgr = [YDAudioControlPannelMgr shared];
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 153);
    mgr.createAControlPannel(rect).bgColor([UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.9]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
