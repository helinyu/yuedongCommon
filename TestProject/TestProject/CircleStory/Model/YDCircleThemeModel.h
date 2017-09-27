//
//  YDCircleThemeModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/12/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@interface YDCircleThemeModel : NSObject<MSJsonSerializing>

@property (nonatomic, strong) NSNumber *themeId;
@property (nonatomic,   copy) NSString *themeTitle;
@property (nonatomic,   copy) NSString *themeIconUrl;

@end
