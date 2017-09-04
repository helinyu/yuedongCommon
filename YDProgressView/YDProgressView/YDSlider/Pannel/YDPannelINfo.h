//
//  YDPannelINfo.h
//  YDProgressView
//
//  Created by Aka on 2017/9/4.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDPannelINfo : NSObject

- (YDPannelINfo* (^)(NSString *title))evaluateTitle;
- (YDPannelINfo* (^)(NSTimeInterval currentTime))evaluateCurrentTime;
- (YDPannelINfo* (^)(NSTimeInterval totalTime))evaluateTotalTime;
- (YDPannelINfo* (^)(BOOL isPlaying))evaluatePlayingState;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;
@property (nonatomic, assign, readonly) NSTimeInterval totalTime;
@property (nonatomic, assign, readonly) BOOL isPlaying;

@end
