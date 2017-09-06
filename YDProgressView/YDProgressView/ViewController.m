//
//  ViewController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDBase1ViewController.h"
#import "YDBaseSliderController.h"
#import "YDSliderViewController.h"
#import "RCDraggableButton.h"
#import "YDPlayerViewController.h"
#import "YDNSProgressViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSArray *dataSources;

@end

static NSString *const reuseCellIdentifier = @"reuse.cell.identifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseInit];
    
}



- (void)baseInit {
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCellIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _dataSources = @[@"基础属性设置,progress",@"slider 的设置",@"重写slider",@"NSProgess的使用",@"AVPlayer play auido"];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _dataSources[indexPath.row];
    return cell;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[YDBase1ViewController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[YDBaseSliderController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[YDSliderViewController new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[YDNSProgressViewController new] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[YDPlayerViewController new] animated:YES];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
