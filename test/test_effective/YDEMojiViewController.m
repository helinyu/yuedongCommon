//
//  YDEMojiViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/16.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDEMojiViewController.h"

@interface YDEMojiViewController ()

@property (nonatomic, strong) UILabel *emojiLabel;
@property (nonatomic, strong) UILabel *emojiLaterLabel;

@end

@implementation YDEMojiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _emojiLabel = [UILabel new];
    [self.view addSubview:_emojiLabel];
    _emojiLabel.backgroundColor = [UIColor grayColor];
    _emojiLabel.frame = CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds), 100);
    
    _emojiLaterLabel = [UILabel new];
    [self.view addSubview:_emojiLaterLabel];
    _emojiLaterLabel.backgroundColor = [UIColor grayColor];
    _emojiLaterLabel.frame = CGRectMake(0, 250, CGRectGetWidth([UIScreen mainScreen].bounds), 200);

    //在这里以😀表情为例,😀的Unicode编码为U+1F604,UTF-16编码为:\ud83d\ude04
    NSString * emojiUnicode = @"\U0001F60E";  // xx  \U0001F635 \U0001F611 \U0001F604 \U0001F609 \U0001F625 \U0000263A \U0001F60E \U0001F606
    
    NSLog(@"emojiUnicode:%@",@"\U0001F606");
    NSLog(@"emojiUnicode:%@",@"\U0001F60E");
    NSLog(@"emojiUnicode:%@",@"\U0000263A");
    NSLog(@"emojiUnicode:%@",@"\U0001F625");
    NSLog(@"emojiUnicode:%@",@"\U0001F609");
    NSLog(@"emojiUnicode:%@",@"\U0001F604");
    NSLog(@"emojiUnicode:%@",@"\U0001F611");
    NSLog(@"emojiUnicode:%@",@"\U0001F635");
    NSLog(@"emojiUnicode  :%@",emojiUnicode);
    
    _emojiLaterLabel.text = emojiUnicode;
    //如果直接输入\ud83d\ude04会报错，加了转义后不会报错，但是会输出字符串\ud83d\ude04,而不是😀
    NSString * emojiUTF16 = @"\\ud83d\\ude04";
    NSLog(@"emojiUTF16:%@",emojiUTF16);
    
    //转换
    emojiUTF16 = [NSString stringWithCString:[emojiUTF16 cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    NSLog(@"emojiUnicode2:%@",emojiUTF16);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
