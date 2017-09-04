//
//  YDPannelINfo.m
//  YDProgressView
//
//  Created by Aka on 2017/9/4.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDPannelINfo.h"

@interface YDPannelINfo ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) BOOL isPlaying;

@end

@implementation YDPannelINfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (YDPannelINfo* (^)(NSString *title))evaluateTitle {
    __weak typeof (self) wSelf = self;
    return ^(NSString *title) {
        wSelf.title = title;
        return self;
    };
}

- (YDPannelINfo* (^)(NSTimeInterval currentTime))evaluateCurrentTime {
    __weak typeof (self) wSelf = self;
    return ^(NSTimeInterval currentTime) {
        wSelf.currentTime = currentTime;
        return self;
    };
}

- (YDPannelINfo* (^)(NSTimeInterval totalTime))evaluateTotalTime {
    __weak typeof (self) wSelf = self;
    return ^(NSTimeInterval totalTime) {
        wSelf.totalTime = totalTime;
        return self;
    };
}

- (YDPannelINfo* (^)(BOOL isPlaying))evaluatePlayingState {
    __weak typeof (self) wSelf = self;
    return ^(BOOL isPlaying) {
        wSelf.isPlaying = isPlaying;
        return self;
    };
}
@end
