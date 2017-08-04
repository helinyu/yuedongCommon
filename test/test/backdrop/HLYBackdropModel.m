//
//  HLYBackdropModel.m
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYBackdropModel.h"

@interface HLYBackdropModel ()

@end

@implementation HLYBackdropModel

@end

@interface HLYBackdropOnlineModel ()

@property (nonatomic, copy, readwrite) NSString *picUrl;
@property (nonatomic, assign, readwrite) HLYPicStatusType type;
@property (nonatomic, copy, readwrite) NSString *statusImageUrl;

@end

@implementation HLYBackdropOnlineModel

- (void)configureItemWithType:(HLYPicStatusType)type picUrl:(NSString *)url progress:(CGFloat)progress statusImage:(NSString *)iconUrlString {
    self.picUrl = url;
    self.type = type;
    self.progress = progress;
    self.statusImageUrl = iconUrlString;
}

@end
