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
    layout.minimumLineSpacing = 2.f;
    layout.minimumInteritemSpacing = 2.f;
    layout.sectionInset =UIEdgeInsetsMake(10, 10, -40, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[YDCustomCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([YDCustomCollectionViewCell class])];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_collectionView];
//    这里就是一行中按照这个规则来排3个内容
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
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGFloat)sectionSpacingForCollectionView:(UICollectionView *)collectionView {
    return 100; // section 之间的距离
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForLargeItemsInSection:(NSInteger)section {
    return CGSizeMake(100, 100);
}

//- (UIEdgeInsets)insetsForCollectionView:(UICollectionView *)collectionView {
//    return UIEdgeInsetsMake(10, 10, -40, 10);
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(0, 0);
//}
// 重新布局了之后，一些内容就没有使用了，尤其是初始化上

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did selected idnexPath:%zd ,item :%zd",indexPath.section, indexPath.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
