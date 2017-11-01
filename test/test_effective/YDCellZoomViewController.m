//
//  YDCellZoomViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/1.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDCellZoomViewController.h"
#import "YDImgZoomCCell.h"
#import "Masonry.h"

@interface YDCellZoomViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YDCellZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.f;
    flowLayout.minimumInteritemSpacing = 0.f;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_collectionView registerClass:[YDImgZoomCCell class] forCellWithReuseIdentifier:NSStringFromClass([YDImgZoomCCell class])];
    self.collectionView.dataSource= self;
    self.collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDImgZoomCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDImgZoomCCell class]) forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

@end
