//
//  ViewController.m
//  YY
//
//  Created by Aka on 2017/8/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "TestYYImageViewController.h"
#import "TestWebPViewController.h"
#import "TestAPNGViewController.h"
#import "YYImageFrameViewController.h"
#import "TestSpriteViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSArray *dataSources;

@end

static NSString *const reuserCellIdentifierId = @"reuse.cell.identifier.id";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserCellIdentifierId];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _dataSources = @[@"gif 图片",@"webP图片",@"APNG 图片",@"加载多图",@"加载精灵图片",];
    
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserCellIdentifierId forIndexPath:indexPath];
    cell.textLabel.text = _dataSources[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[TestYYImageViewController new] animated:true];
            break;
        case 1:
            [self.navigationController pushViewController:[TestWebPViewController new] animated:true];
            break;
        case 2:
            [self.navigationController pushViewController:[TestAPNGViewController new] animated:true];
            break;
        case 3:
            [self.navigationController pushViewController:[YYImageFrameViewController new] animated:true];
            break;
        case 4:
            [self.navigationController pushViewController:[TestSpriteViewController new] animated:true];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
