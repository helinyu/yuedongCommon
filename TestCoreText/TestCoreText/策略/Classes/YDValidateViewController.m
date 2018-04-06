//
//  YDValidateViewController.m
//  TestCoreText
//
//  Created by Aka on 2018/4/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDValidateViewController.h"
#import <Masonry.h>
#import "NumericInputValidator.h"
#import "AlphaInputValidator.h"
#import "CustomTextField.h"

@interface YDValidateViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textfield;

@end

@implementation YDValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textfield = [CustomTextField  new];
    [self.view addSubview:_textfield];
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(200.f);
        make.height.mas_equalTo(100.f);
    }];
    _textfield.delegate = self;
    _textfield.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(300.f);
        make.width.height.mas_equalTo(100.f);
    }];
    [btn setTitle:@"验证" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)onTap {
    [self.textfield resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isKindOfClass:[CustomTextField class]])
    {
        [(CustomTextField*)textField validate];
    }
}

@end
