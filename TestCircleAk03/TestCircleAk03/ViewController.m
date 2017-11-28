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

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) YDDynamicDetailHeaderView *headerView;

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
}

#pragma mark -- datasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDCommentTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YDCommentTCell class]) forIndexPath:indexPath];
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
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGRectGetWidth([UIScreen mainScreen].bounds));
        make.height.mas_equalTo(200.f);
    }];
    
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
