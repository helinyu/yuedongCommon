//
//  YDAudioMgr.h
//  Test_Audio
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface YDAudioMgr : NSObject
    
+ (instancetype)shared;
- (void)loadBase;
    
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSArray *lrcs;

- (void)playControl;
- (void)createRemoteCommandCenter;
    
@end
