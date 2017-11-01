//
//  YDAlbumViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDTest1AlbumViewController.h"
#import "QMUIAssetsManager.h"

@interface YDTest1AlbumViewController ()
{
    NSMutableArray *_albumsArray;
    
    BOOL _usePhotoKit;
}

@end


@implementation YDTest1AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self test0];
    
}

- (void)test0 {
    if ([QMUIAssetsManager authorizationStatus] == QMUIAssetAuthorizationStatusNotAuthorized) {
        // 如果没有获取访问授权，或者访问授权状态已经被明确禁止，则显示提示语，引导用户开启授权
//        NSLog(@"已经被禁止了");
//                NSString *tipString = self.tipTextWhenNoPhotosAuthorization;
//                if (!tipString) {
//                    NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
//                    NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
//                    if (!appName) {
//                        appName = [mainInfoDictionary objectForKey:(NSString *)kCFBundleNameKey];
//                    }
//                    tipString = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
//                }
    } else {
        
        _albumsArray = @[].mutableCopy;
        // 获取相册列表较为耗时，交给子线程去处理，因此这里需要显示 Loading
        //        if ([self.albumViewControllerDelegate respondsToSelector:@selector(albumViewControllerWillStartLoad:)]) {
        //            [self.albumViewControllerDelegate albumViewControllerWillStartLoad:self];
        //        }
        //        if (self.shouldShowDefaultLoadingView) {
        //            [self showEmptyViewWithLoading];
        //        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[QMUIAssetsManager sharedInstance] enumerateAllAlbumsWithAlbumContentType:QMUIAlbumContentTypeAll usingBlock:^(QMUIAssetsGroup *resultAssetsGroup) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 这里需要对 UI 进行操作，因此放回主线程处理
                    if (resultAssetsGroup) {
                        [_albumsArray addObject:resultAssetsGroup];
                    } else {
                        [self refreshAlbumAndShowEmptyTipIfNeed];
                    }
                });
            }];
        });
    }
}


- (void)refreshAlbumAndShowEmptyTipIfNeed {
    if ([_albumsArray count] > 0) {
        NSLog(@"folder count: %lu",(unsigned long)_albumsArray.count);
        
        for (NSInteger index =0; index< _albumsArray.count; index++) {
            QMUIAssetsGroup *assetGroup = [_albumsArray objectAtIndex:index];
            NSLog(@"asset name:%@",assetGroup.name);
        }
//        QMUIAssetsGroup *assetsGroup = [_albumsArray objectAtIndex:];

        //        if ([self.albumViewControllerDelegate respondsToSelector:@selector(albumViewControllerWillFinishLoad:)]) {
        //            [self.albumViewControllerDelegate albumViewControllerWillFinishLoad:self];
        //        }
        //        if (self.shouldShowDefaultLoadingView) {
        //            [self hideEmptyView];
        //        }
        //        [self.tableView reloadData];
    } else {
        NSLog(@"没有照片");
        //        NSString *tipString = self.tipTextWhenPhotosEmpty ? : @"空照片";
        //        [self showEmptyViewWithText:tipString detailText:nil buttonTitle:nil buttonAction:nil];
    }
}
@end

