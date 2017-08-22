//
//  YDAudioMgr.m
//  Test_Audio
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDAudioMgr.h"
#import <AVFoundation/AVFoundation.h>
#import "wslAnalyzer.h"

@interface YDAudioMgr ()
    
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSArray *lrcs;
    
@end

@implementation YDAudioMgr

- (void)loadBase {
    [self _getLrcArray];
}
    
- (AVPlayer *)player {
    if (_player == nil) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"多幸运" ofType:@"mp3"];
        _player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:path]];
    }
    return _player;
}
    
//获得歌词数组
- (void)_getLrcArray{
    wslAnalyzer *  analyzer = [wslAnalyzer new];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"多幸运" ofType:@"txt"];
    self.lrcs =  [analyzer analyzerLrcBylrcString:[NSString  stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]];
    NSLog(@"self.lrcs count; %lu",(unsigned long)self.lrcs.count);
}

@end
