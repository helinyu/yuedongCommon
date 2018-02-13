//
//  YDChartLineModel.h
//  TestCoreText
//
//  Created by mac on 13/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDChartLineModel : NSObject

@property (nonatomic, assign) NSInteger detaNum;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL hasDot;
@property (nonatomic, assign) CGFloat dotPoint;
@property (nonatomic, copy) NSString *dotText;

@property (nonatomic, assign) CGFloat beginPoint;
@property (nonatomic, assign) CGFloat endPoint;

@property (nonatomic, copy) NSString *timeText;

@end
