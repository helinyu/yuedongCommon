//
//  YDAlbumMgr.h
//  test_effective
//
//  Created by Aka on 2017/10/27.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface YDAlbumMgr : NSObject

+ (instancetype)shared;

- (void)loadAlbumsThen:(void(^)(NSArray<ALAsset *> * imgs))then;
@end
