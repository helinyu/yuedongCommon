//
//  HLYTableViewViewController.m
//  test
//
//  Created by felix on 2017/6/2.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYTableViewViewController.h"

@interface HLYTableViewViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HLYTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"test%ld",(long)indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}


@end
