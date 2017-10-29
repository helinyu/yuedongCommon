//
//  YDImgPickerViewController.m
//  SportsBar
//
//  Created by Aka on 2017/10/29.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import "YDImgPickerViewController.h"
#import "Masonry.h"
#import "YDSingleImgCCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface YDImgPickerViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) ALAssetsLibrary *library;

@property (nonatomic, strong) NSMutableArray *datas;

@end

static NSString *const kImgPickerTakeCellCIdentifier = @"k.img.picker.take.cell.C.identifier";

@implementation YDImgPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.view addSubview:_collectionView];
//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.top.equalTo(self.view);
//    }];
    [_collectionView registerClass:[YDSingleImgCCell class] forCellWithReuseIdentifier:kImgPickerTakeCellCIdentifier];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor blueColor];
    [self test0];
}

- (void)test0 {
    _datas = @[].mutableCopy;
    __weak typeof (self) wSelf = self;
    _library = [ALAssetsLibrary new];
    NSMutableArray   *assets = [NSMutableArray new];
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSLog(@"get albums ");
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (nil == result) {
                _datas = assets;
                NSLog(@"datas count: %lu",(unsigned long)_datas.count);
                [wSelf.collectionView reloadData];
                return;
            }
            [assets addObject:result];
        }];
    } failureBlock:^(NSError *error) {
        NSLog(@"get albums error :%@",error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDSingleImgCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImgPickerTakeCellCIdentifier forIndexPath:indexPath];
    ALAsset *asset = _datas[indexPath.item];
    cell.imgView.image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}

@end
