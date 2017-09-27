//
//  YDCircleTopicViewController.h
//  SportsBar
//
//  Created by 颜志浩 on 16/12/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDMBaseViewController.h"

@interface YDCircleTopicViewController : YDMBaseViewController

@property (nonatomic, strong) NSNumber *subThemeId;
@property (nonatomic,   copy) NSString *navTitle;

- (instancetype)initWithSubThemeId:(NSNumber *)subThemeId navTitle:(NSString *)navTitle;

@end
