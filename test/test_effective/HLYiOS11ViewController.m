//
//  HLYiOS11ViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYiOS11ViewController.h"
#import "Masonry.h"
#import <YYKit.h>

@interface HLYiOS11ViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation HLYiOS11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    self.view.pasteConfiguration = [UIPasteConfiguration new];
    
    _imgView = [UIImageView new];
    [self.view addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(100);
    }];
//    _imgView.image = [UIImage imageNamed:@"test.gif"];
    
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
