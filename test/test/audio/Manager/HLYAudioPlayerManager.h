//
//  HLYAudioPlayer.h
//  AudioResolution
//
//  Created by felix on 2017/6/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLYAudioPlayerManager : NSObject

+ (instancetype)shareInstance;
//Create singleton object

- (void)playerAudioWithUrl:(NSString *)urlString;



@end
