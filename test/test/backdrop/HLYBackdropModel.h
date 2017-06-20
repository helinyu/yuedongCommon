//
//  HLYBackdropModel.h
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HLYPicStatusType) {
    HLYPicStatusTypeLoadNeed = 0,
    HLYPicStatusTypeLoading,
    HLYPicStatusTypeLoaded,
    HLYPicStatusTypeChoice
};

@interface HLYBackdropModel : NSObject

@end

@interface HLYBackdropOnlineModel : HLYBackdropModel

@property (nonatomic, copy, readonly) NSString *picUrl;
@property (nonatomic, assign, readonly) HLYPicStatusType type;
@property (nonatomic, assign, readonly) CGFloat progress;
@property (nonatomic, copy, readonly) NSString *statusImageUrl;

- (void)configureItemWithType:(HLYPicStatusType)type picUrl:(NSString *)url progress:(CGFloat)progress statusImage:(NSString *)iconUrlString;

@end
