//
//  BackDropMgr.h
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HLYBackdropOnlineModel;

@interface HLYBackDropMgr : NSObject

@property (nonatomic, strong, readonly) NSArray *pictureSourcesCategories;
@property (nonatomic, strong, readonly) NSArray<HLYBackdropOnlineModel *> *onlinePicSources;


+ (instancetype)shareInstance;
- (void)initPictureSourcesCategories;
- (void)initOnlinPictureSoruces;

@end


typedef NS_ENUM(NSInteger, HLYSourceType) {
    HLYSourceTypeOnline = 0,
    HLYSourceTypeAlbum = 10,
    HLYSourceTypeCamera = 11
};
