//
//  ViewController.m
//  TestCircleAk03
//
//  Created by Aka on 2017/11/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDCommentTCell.h"
#import "YDDynamicDetailHeaderView.h"
#import "Masonry.h"
//#import "IQTextView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) YDDynamicDetailHeaderView *headerView;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动态详情页面";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[YDCommentTCell class] forCellReuseIdentifier:NSStringFromClass([YDCommentTCell class])];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
//    _textView = [[IQTextView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) -50.f, CGRectGetWidth([UIScreen mainScreen].bounds) -100, 50.f)];;
    _textView = [UITextView new];
    [self.view addSubview:_textView];
    _textView.backgroundColor = [UIColor blueColor];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangedNoti:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onHideNoti:) name:UIKeyboardWillHideNotification object:nil];
    
    _sender = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_sender];
    [_sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textView.mas_right);
        make.centerY.equalTo(_textView);
        make.width.mas_equalTo(100);
    }];
    [_sender setTitle:@"fasong" forState:UIControlStateNormal];
    [_sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

#pragma mark -- datasource & delegate

- (void)onHideNoti:(NSNotification *)noti {
//    self.textView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) -50.f,  CGRectGetWidth([UIScreen mainScreen].bounds) -100,  50.f);
    [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
}

- (void)onChangedNoti:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    if (height >0.f) {
//        self.textView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) -50.f - height,  CGRectGetWidth([UIScreen mainScreen].bounds) -100,  50.f);
        [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(height);
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDCommentTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YDCommentTCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"iunde x :%ld",indexPath.row];
    return cell;
}

// 考虑圈子和点赞的内容放在tableHeaderView和sectionheaderView 上 (为一个一个不会改变的就是下-面的comment是不会改变的)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YDDynamicDetailHeaderView *headerView = [YDDynamicDetailHeaderView new];
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(CGRectGetWidth([UIScreen mainScreen].bounds));
//        make.height.mas_equalTo(200.f);
//    }];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did select");
    
    [_textView resignFirstResponder];
    NSURL *url = [NSURL URLWithString:@"prefs:root=Wallpaper"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else {
        NSLog(@"不能够打开这个文件");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
