//
//  YDCircleThemeViewController.h
//  SportsBar
//
//  Created by 颜志浩 on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDMBaseViewController.h"

@interface YDCircleThemeViewController : YDMBaseViewController

@property (nonatomic, strong) NSNumber *themeId;
@property (nonatomic,   copy) NSString *navTitle;

- (instancetype)initWithThemeId:(NSNumber *)themeId title:(NSString *)title;

@end
