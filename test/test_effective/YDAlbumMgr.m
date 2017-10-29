//
//  YDAlbumMgr.m
//  test_effective
//
//  Created by Aka on 2017/10/27.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDAlbumMgr.h"

@implementation YDAlbumMgr

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (void)loadAlbumsThen:(void(^)(NSArray<ALAsset *> * imgs))then {
    NSMutableArray   *assets = [NSMutableArray new];
    [[ALAssetsLibrary new] enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSLog(@"get albums ");
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (nil == result) {
                !then? :then(assets);
                return;
            }
            [assets addObject:result];
        }];
    } failureBlock:^(NSError *error) {
        NSLog(@"get albums error :%@",error);
    }];
}

@end
