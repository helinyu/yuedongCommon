//
//  YDSongEnty.h
//  _YDBridgeWebViewController
//
//  Created by Aka on 2017/8/21.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YDMediaItem;

@interface YDMedia : NSObject
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray<YDMediaItem *> *mediaItemList;

+ (YDMedia *)mediaConvertionWithDic:(NSDictionary *)dic;

@end

@interface YDMediaItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *mediaUrlStr;
@property (nonatomic, copy) NSString *imgUrlStr;
@property (nonatomic, copy) NSString *speaker;

@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSTimeInterval totalTime;

@end
