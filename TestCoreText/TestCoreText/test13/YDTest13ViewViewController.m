//
//  YDTest13ViewViewController.m
//  TestCoreText
//
//  Created by mac on 5/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest13ViewViewController.h"
#import "UIView+frameAdjust.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "YDTest13TableViewCell.h"

@interface YDTest13ViewViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YDTest13ViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _tableView = [UITableView new];
    _tableView.frame = self.view.bounds;
    [_tableView registerClass:[YDTest13TableViewCell class] forCellReuseIdentifier:NSStringFromClass([YDTest13TableViewCell class])];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDTest13TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YDTest13TableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row %2 == 0) {
        [cell prepareForReuse];
        cell.msLabel.text = [NSString stringWithFormat:@"gh-R row :%zd",indexPath.row];
        cell.backgroundColor = [UIColor blueColor];
        cell.msLabel.backgroundColor = [UIColor greenColor];
    }
    else {
        [cell prepareForReuse];
        cell.titleLabel.text = [NSString stringWithFormat:@"gh-L row :%zd",indexPath.row];
        cell.backgroundColor = [UIColor purpleColor];
    }
    return cell;
}

@end
