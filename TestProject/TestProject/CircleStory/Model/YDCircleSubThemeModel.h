//
//  YDCircleSubThemeModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@interface YDCircleSubThemeModel : NSObject<MSJsonSerializing>

@property (nonatomic, strong) NSNumber *subThemeIconId;
@property (nonatomic, strong) NSNumber *subThemeId;
@property (nonatomic,   copy) NSString *subThemeIconUrl;
@property (nonatomic, strong) NSNumber *subThemeNum;
@property (nonatomic,   copy) NSString *subThemeNumStr;
@property (nonatomic,   copy) NSString *subThemeTitle;
@property (nonatomic, strong) NSNumber *subThemeType;
@property (nonatomic,   copy) NSString *subThemeUnit;
@property (nonatomic,   copy) NSString *recommendTitle;

@end
