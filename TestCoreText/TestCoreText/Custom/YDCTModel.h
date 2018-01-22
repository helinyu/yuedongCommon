//
//  DYCTCoreTextModel.h
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface YDCTModel : NSObject

@property (nonatomic, assign) CTFrameRef ctFrame; // fame值会发生变化
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSArray *imgs;
//图片的位置信息
@property (nonatomic, strong) NSArray *links;
// 链接的位置信息
@property (nonatomic, strong) NSAttributedString *content;
// 所有的富文本

@end
