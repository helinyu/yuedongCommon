//
//  HLYMIneTAbleViewController.m
//  test
//
//  Created by felix on 2017/6/6.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYMIneTAbleViewController.h"
#import "HLYBaseView.h"
#import "HLYCollectionViewCell.h"
#import "HLYTopTableViewCell.h"
#import "HLYRelativeCollectionViewCell.h"


@interface HLYMIneTAbleViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) HLYBaseView *baseView;

@property (nonatomic, strong) HLYTopTableViewCellModel *model;

@end

static const NSInteger numberOfSections = 4;
static NSString *const tableViewCellId = @"mine.tableview.cell.id";

@implementation HLYMIneTAbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.hidesBarsOnTap = NO;
    self.navigationController.hidesBarsOnSwipe = NO;
    
    _baseView = [[HLYBaseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_baseView];
    
    [self.baseView.tableView registerClass:[HLYTopTableViewCell class] forCellReuseIdentifier:tableViewCellId];
    self.baseView.tableView.dataSource = self;
    self.baseView.tableView.delegate = self;
    
    self.baseView.backgroundColor = [UIColor clearColor];
    [self dataInit];
}

- (void)dataInit {
    self.model = [HLYTopTableViewCellModel new];
    self.model.titleText = @"标题";
    self.model.descriptionText = @"描述";
    self.model.relatives = @[
                        @"cell1",
                        @"cell2",
                        @"cell3",
                        @"cell4"
                        ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- tableView datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfSections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HLYTopTableViewCell *cell = [HLYTopTableViewCell reuseCell:tableView indentifier:tableViewCellId indexPath:indexPath model:self.model];
    [cell.relativeCollectionView registerClass:[HLYRelativeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HLYRelativeCollectionViewCell class])];
    cell.relativeCollectionView.dataSource = self;
    cell.relativeCollectionView.delegate = self;
    [cell.relativeCollectionView reloadData];
    return cell;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0f;
}

#pragma mark -- collection view datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.relatives.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLYRelativeCellModel *model = [HLYRelativeCellModel configureTitle:@"hahha" numText:@"adjf" updateNumText:@"23"];
    HLYRelativeCollectionViewCell *cell = [HLYRelativeCollectionViewCell reuseCollectionVeiw:collectionView withIdentifier:NSStringFromClass([HLYRelativeCollectionViewCell class]) indexPath:indexPath model:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}



@end
