//
//  HLYTableViewController.m
//  test
//
//  Created by felix on 2017/5/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYTableViewController.h"
#import "HLYWeightAndFatCell.h"
#import "HLYWeightAndFatModel.h"

@interface HLYTableViewController ()

@end

static NSString *const cellIdentifier = @"weight.and.fat.cell.id";

@implementation HLYTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"测试";
    [self.tableView registerClass:[HLYWeightAndFatCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.allowsSelection = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLYWeightAndFatModel *model = [HLYWeightAndFatModel new];
    HLYWeightAndFatCell *cell = [HLYWeightAndFatCell reusableCellForTableView:tableView cellId:cellIdentifier model:model indexPath:indexPath action:^{
        
    }];
    cell.backgroundColor = [UIColor blueColor];
    cell.selected = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 194.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
