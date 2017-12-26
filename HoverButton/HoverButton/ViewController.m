//
//  ViewController.m
//  HoverButton
//
//  Created by Aka on 2017/8/31.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"

#import "YD1ViewController.h"
#import "YD2ViewController.h"
#import "YD3ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSoruces;

@property (nonatomic, strong) UIWindow *btnWindow;

@end

static NSString *const reuserTableViewCellIdentifier = @"tableView.cell.identifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserTableViewCellIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _dataSoruces = @[@"基础属性测试",@"按钮内的图片滚动",@"多线程的处理"];

}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSoruces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserTableViewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _dataSoruces[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            YD1ViewController *vc = [YD1ViewController new];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 1:
        {
            YD2ViewController *vc2 = [YD2ViewController new];
            [self presentViewController:vc2 animated:YES completion:nil];
        }
            break;
        case 2:
        {
            YD3ViewController *vc3 = [YD3ViewController new];
            [self presentViewController:vc3 animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
