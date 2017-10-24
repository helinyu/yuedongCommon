//
//  ViewController.m
//  test_effective
//
//  Created by felix on 2017/6/21.
//  Copyright © 2017年 forest. All rights reserved.
///Users/felix/yuedongCommon/test/test_effective/第2章

#import "HLYPropertyViewController.h"

#import "ViewController.h"
#import "HLy7ViewController.h"
#import "HLY8ViewController.h"
#import "HLYTestModelViewController.h"
#import "YDEMojiViewController.h"
#import "YDLabelViewController.h"
#import "HLYResponderiewController.h"
#import "HLYiOS11ViewController.h"
#import "YDNSNullViewController.h"
#import "YDShadowViewController.h"
#import "YDCoreTextViewController.h"
#import "YDTestYYLabelViewController.h"
#import "YDDrawViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"所有实例列表";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataSource = @[
                        @[@"测试yymodel",[HLYTestModelViewController new]],
                        @[@"第八条特性的理解",[HLY8ViewController new]],
                        @[@"setter 或者getter 使用",[HLy7ViewController new]],
                        @[@"属性测试",[HLYPropertyViewController new]],
                        @[@"emoji",[YDEMojiViewController new]],
                        @[@"label 计算高度",[YDLabelViewController new]],
                        @[@"responder 内容",[HLYResponderiewController new]],
                        @[@"ios 11的新特性",[HLYiOS11ViewController new]],
                        @[@"nsnull 上面的内容",[YDNSNullViewController new]],
                        @[@"view 上的shadow",[YDShadowViewController new]],
                        @[@"core text 测试",[YDCoreTextViewController new]],
                        @[@"yylabel test & dicover",[YDTestYYLabelViewController new]],
                        @[@"UIView 上绘画-文本",[YDDrawViewController new]],
                        ];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row][0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:self.dataSource[indexPath.row][1] animated:true];
}

@end
