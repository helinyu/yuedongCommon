//
//  YDTest10ViewController.m
//  TestCoreText
//
//  Created by mac on 31/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest10ViewController.h"
#import "RACollectionViewReorderableTripletLayout.h"
#import "YDCustomCollectionViewCell.h"

@interface YDTest10ViewController ()<RACollectionViewTripletLayoutDatasource,RACollectionViewDelegateTripletLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YDTest10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    RACollectionViewTripletLayout *layout = [RACollectionViewTripletLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[YDCustomCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([YDCustomCollectionViewCell class])];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDCustomCollectionViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd%zd",indexPath.section, indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
