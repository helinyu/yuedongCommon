//
//  HLYAnimationCollectionViewController.m
//  test
//
//  Created by Aka on 2017/7/4.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYAnimationCollectionViewController.h"
#import "AnimationCollectionViewCell.h"

@interface HLYAnimationCollectionViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<AnimationCollectionModel *> *datas;

@end

@implementation HLYAnimationCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[AnimationCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _datas = [NSMutableArray<AnimationCollectionModel *> new];
    for (NSInteger index =0; index < 100; index++) {
        AnimationCollectionModel *item = [AnimationCollectionModel new];
        item.type = 0;
        item.title = [NSString stringWithFormat:@"title : %ld",(long)index];
        [_datas addObject:item];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AnimationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell configureAnimationWithIem:_datas[indexPath.row]];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _datas[indexPath.row].type = 1;
    [_collectionView reloadItemsAtIndexPaths:@[indexPath]];
}


@end
