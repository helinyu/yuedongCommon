//
//  YDPhotoTakenMgr.m
//  test_effective
//
//  Created by Aka on 2017/11/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDPhotoTakenMgr.h"

@interface YDPhotoTakenMgr ()

@property (strong, nonatomic) AVCaptureSession *captureSession;


@end

@implementation YDPhotoTakenMgr

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    
}

@end
