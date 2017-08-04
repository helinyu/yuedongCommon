//
//  BackDropMgr.m
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYBackDropMgr.h"
#import "HLYBackdropModel.h"

@interface HLYBackDropMgr ()

@property (nonatomic, strong, readwrite) NSMutableArray *pictureSourcesCategories;
@property (nonatomic, strong, readwrite) NSMutableArray<HLYBackdropOnlineModel *> *onlinePicSources;

@end

static HLYBackDropMgr *singleTon = nil;

@implementation HLYBackDropMgr

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = [HLYBackDropMgr new];
    });
    return singleTon;
}

- (void)initPictureSourcesCategories {
    NSArray *categories = @[@[@"选择背景"],
                            @[@"从手机相册选择",@"拍一张"]
                            ];
    if (!_pictureSourcesCategories) {
        _pictureSourcesCategories = [NSMutableArray new];
    }
    [_pictureSourcesCategories addObjectsFromArray:categories];
    
}

- (void)initOnlinPictureSoruces {
   
    if (!_onlinePicSources) {
        _onlinePicSources = [NSMutableArray new];
        for (NSInteger index = 0; index < 9; index++) {
            NSInteger currentType = index %4;
            NSInteger hah = index/4;
            NSString *statusImageUrl = @"";
            CGFloat progressPercent = 0.f;
            switch (currentType) {
                case HLYPicStatusTypeLoadNeed:
                    statusImageUrl = @"icon_download";
                    progressPercent = 0.f;
                    break;
                case HLYPicStatusTypeLoading:
                {
                    if (hah == 0) {
                        progressPercent = 0.f;
                    }else if(hah == 1) {
                        progressPercent = .3f;
                    }
                }
                    break;
                case HLYPicStatusTypeLoaded:
                    break;
                case HLYPicStatusTypeChoice:
                {
                    progressPercent = 1.f;
                    statusImageUrl = @"icon_default_choice";
                }
                    break;
                default:
                    break;
            }
            HLYBackdropOnlineModel *item = [HLYBackdropOnlineModel new];
            [item configureItemWithType:currentType picUrl:@"Snip20170620_1.png" progress:progressPercent statusImage:statusImageUrl];
            [_onlinePicSources addObject:item];
        }
    }
  
}

@end
