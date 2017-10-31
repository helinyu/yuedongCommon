//
//  YDPhotoViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/26.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDPhotoViewController.h"
#import "QMUIKit.h"
#import "YDSingleImgCCell.h"
#import "YDAlbumMgr.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface YDPhotoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) ALAssetsLibrary *library;

@property (nonatomic, strong) PHPhotoLibrary *phLibrary;

@property (nonatomic, strong) PHFetchResult<PHAsset *> *allPhotos;

@property (nonatomic, assign) NSInteger index;

@end

@implementation YDPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[YDSingleImgCCell class] forCellWithReuseIdentifier:NSStringFromClass([YDSingleImgCCell class])];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    
//    [self test0];
    [self test1];
}

- (void)test1 {
    
    _index = 1;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status != PHAuthorizationStatusAuthorized) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status != PHAuthorizationStatusAuthorized) {
                NSLog(@"can not get the author");
                return ;
            }
        }];
    }
    
    _phLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    [_phLibrary registerChangeObserver:self];
    
    __block NSString *createdAssetID =nil;//唯一标识，可以用于图片资源获取
    NSError *error =nil;

    PHFetchOptions *options = [PHFetchOptions new];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    _allPhotos = [PHAsset fetchAssetsWithOptions:options];

//    Create a PHFetchResult object for each section in the table view.
//    allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
//    smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
//    userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
//
//    PHPhotoLibrary.shared().register(self)

//    [PHAssetResourceManager share];
//    [_phLibrary performChanges:^{
//        NSLog(@"performChanges");
//        createdAssetID = [PHAssetChangeRequest            creationRequestForAssetFromImage:nil].placeholderForCreatedAsset.localIdentifier;
//
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        NSLog(@"flag : %d ; erorr :%@",success,error);
//    }];
//
//    [_phLibrary performChangesAndWait:^{
//        NSLog(@"performChangesAndWait");
//    } error:&error];
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
                    [wSelf.collectionView reloadData];
                    return;
                }
                [assets addObject:result];
            }];
        } failureBlock:^(NSError *error) {
            NSLog(@"get albums error :%@",error);
        }];
}


- (void)dealloc {
    [_phLibrary unregisterChangeObserver:self];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    PHObjectChangeDetails *changeDetails = [changeInstance changeDetailsForObject:[PHObject new]]; /// for specifiy obj
    PHFetchResultChangeDetails *resultChangeDetails = [changeInstance changeDetailsForFetchResult:[PHFetchResult new]];
}

#pragma mark -- collectionview datasource & delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_index == 0) {
        return _datas.count;
    }
    else {
        return _allPhotos.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDSingleImgCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDSingleImgCCell class]) forIndexPath:indexPath];
    if (_index == 0) {
        ALAsset *asset = _datas[indexPath.item];
        cell.imgView.image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    }else {
        PHAsset *asset = _allPhotos[indexPath.item];
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(50.f, 50.f) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsResizeModeNone resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            cell.imgView.image = result;
        }];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}

@end
