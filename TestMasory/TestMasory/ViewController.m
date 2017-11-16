//
//  ViewController.m
//  TestMasory
//
//  Created by Aka on 2017/11/15.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "YDTestParallaxDimmingViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, strong) UIView *twoView;

@property (nonatomic, strong) NSArray *datasources;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _datasources = @[
                     @[@"测试 时差调光view",[YDTestParallaxDimmingViewController new]],
                     
                    ];
    
    
}

- (void)test0 {
    [self.view addSubview:self.oneView];
    [self.view addSubview:self.twoView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    [btn setTitle:@"切换视图" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didButtton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor greenColor];
}

-  (UIView *)oneView {
    if (!_oneView) {
        _oneView = [[UIView alloc] initWithFrame:self.view.frame];
        _oneView.backgroundColor = [UIColor redColor];
    }
    return _oneView;
}

- (UIView *)twoView {
    if (!_twoView) {
        _twoView = [[UIView alloc] initWithFrame:self.view.frame];
        _twoView.backgroundColor = [UIColor yellowColor];
    }
    return _twoView;
}

- (void)didButtton:(UIButton *)btn {
    [self.view sendSubviewToBack:self.twoView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = _datasources[indexPath.row][0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:_datasources[indexPath.row][1] animated:YES];
}

@end
