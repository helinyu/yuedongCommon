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
#import "YDTestNavigationVC.h"
#import "YDDatasViewController.h"
#import "YDSortViewController.h"
#import "YDScrollCollectionViewController.h"
#import "YDCameraViewController.h"
#import "YDPhotoTakeViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"所有实例列表";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 69, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-69)];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataSource = @[
                        @[@"测试yymodel",[HLYTestModelViewController new]],
                        @[@"第八条特性的理解",[HLY8ViewController new]],
                        @[@"setter 或者getter 使用",[HLy7ViewController new]],
                        @[@"属性测试",[HLYPropertyViewController new]],
                        @[@"测试导航栏",[YDTestNavigationVC new]],
                        @[@"有关的内容",[YDDatasViewController new]],
                        @[@"排序数组",[YDSortViewController new]],
                        @[@"collectionview 滑动不可见",[YDScrollCollectionViewController new]],
                        @[@"相机的实现",[YDCameraViewController new]],
                        @[@"拍照功能",[YDPhotoTakeViewController new]],
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:self.dataSource[indexPath.row][1] animated:true];
}

@end
