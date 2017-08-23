//
//  YDLyricAnalyzer.h
//  TestAudio
//
//  Created by Aka on 2017/8/23.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDLyricAnalyzer : NSObject

@property(nonatomic,strong)NSMutableArray * lrcArray;

/*
 * 文件加载
 */

-(NSMutableArray *)analyzerLrcByPath:(NSString *)path;


/*
 * 直接歌词加载
 */
-(NSMutableArray *)analyzerLrcBylrcString:(NSString *)string;


@property (nonatomic, strong, readonly) NSArray *times;
@property (nonatomic, strong, readonly) NSArray *lyrics;

typedef void (^NSArrayBlock)(NSArray *arrs);
@property (nonatomic, copy) NSArrayBlock timesBlock;
@property (nonatomic, copy) NSArrayBlock lyricsBlock;

@end
