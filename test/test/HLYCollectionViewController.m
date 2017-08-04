
//
//  HLYCollectionViewController.m
//  test
//
//  Created by felix on 2017/6/7.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYCollectionViewController.h"
#import "HLyTestCollectionViewCell.h"

@interface HLYCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HLYCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    
    [self.collectionView registerClass:[HLyTestCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HLyTestCollectionViewCell class])];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-  (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLyTestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HLyTestCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    cell.titleLabel.text = @"hello";
    cell.descriptionLabel.text = @"description";
    return cell;
}

@end
