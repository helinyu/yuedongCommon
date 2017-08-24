//
//  YDAudioMgr.h
//  Test_Audio
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface YDAudioMgr : UIResponder
    
+ (instancetype)shared;
- (void)loadBase;
    
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSArray *lrcs;

//two methods to deal with
- (void)playControl;
- (void)playByTheLyricsTimes;

- (void)createRemoteCommandCenter;
    
@end
