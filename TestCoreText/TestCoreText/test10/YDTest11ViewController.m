//
//  YDTest11ViewController.m
//  TestCoreText
//
//  Created by mac on 1/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest11ViewController.h"
#import "YDCustomCollectionViewCell.h"

@interface YDTest11ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YDTest11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 1.f;
    layout.minimumInteritemSpacing = 1.f;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[YDCustomCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([YDCustomCollectionViewCell class])];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
//    self.view.backgroundColor = [UIColor whiteColor];
    _collectionView.backgroundColor = [UIColor grayColor];
//    完全可以通过这种方式去实现 和tableview 的性能对比，应该性能会降低一点
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDCustomCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDCustomCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
