//
//  YDShadowViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/23.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDShadowViewController.h"
#import "Masonry.h"

@interface YDShadowViewController ()

@property (nonatomic, strong) NSAttributedString *aString;

@end

@implementation YDShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test0];
}

- (void)test0 {
    UIView *view0 = [UIView new];
    [self.view addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(100);
    }];
    view0.backgroundColor = [UIColor greenColor];
    
    view0.layer.shadowPath = [[UIBezierPath bezierPathWithRect:CGRectMake(view0.bounds.origin.x -10, view0.bounds.origin.y -10, 120, 120)] CGPath];
    view0.layer.shadowColor = [UIColor redColor].CGColor;
//    view0.layer.shadowRadius = 10.f; // 这个会向外边缘增加3cm大小
    view0.layer.shadowOpacity = 0.8f;
//    view0.layer.shadowOffset = CGSizeMake(0, 0); // 其实应该就是view上的一个layer放在背景
//    [myView.layer setShadowPath：[[UIBezierPath bezierPathWithRect：view0.bounds] CGPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
