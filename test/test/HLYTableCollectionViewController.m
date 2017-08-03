//
//  HLYTableCollectionViewController.m
//  test
//
//  Created by felix on 2017/6/7.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYTableCollectionViewController.h"
#import "HLYTableCollectionViewCell.h"
#import "HLYInnerCollectionCell.h"

@interface HLYTableCollectionViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HLYTableCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor purpleColor];
    
    [_tableView registerClass:[HLYTableCollectionViewCell class] forCellReuseIdentifier:NSStringFromClass([HLYTableCollectionViewCell class])];
    _tableView.dataSource = self;
    _tableView.delegate = self;

}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLYTableCollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HLYTableCollectionViewCell class]) forIndexPath:indexPath];
    [cell.tableCollectionView registerClass:[HLYInnerCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([HLYInnerCollectionCell class])];
    cell.tableCollectionView.dataSource = self;
    cell.tableCollectionView.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark -- collection view delegate & datasource

-  (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLYInnerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HLYInnerCollectionCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    cell.titleLabel.text = @"hello";
    cell.descriptionLabel.text = @"description";
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 90);
}

@end
