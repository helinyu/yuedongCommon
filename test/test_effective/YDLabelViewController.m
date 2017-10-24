
//
//  YDLabelViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDLabelViewController.h"

@interface YDLabelViewController ()

@end

@implementation YDLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test0];
}

- (void)test0 {
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 200, 400);
    label.backgroundColor = [UIColor grayColor];
//    label.font = YDF_DEFAULT_R_FIT(13.f);
    label.textAlignment = NSTextAlignmentLeft;
//    label.textColor = YDC_TITLE;
    label.numberOfLines = 3;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.text = @"玩法：晒出，简单描述这张照片的意义。\n规则：将从发布照片集赞、评论前100名用户中，抽取5名用户，获得阿迪达斯、哥伦比亚等户外运动装备！";
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
