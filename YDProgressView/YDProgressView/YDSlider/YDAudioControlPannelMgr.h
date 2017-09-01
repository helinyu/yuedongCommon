//
//  YDAudioControlPannelMgr.h
//  SportsBar
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YDAudioControlPannelMgr : NSObject

+ (instancetype)shared;

//- (UIView *)createAControlPannel:(CGRect)rect;

- (YDAudioControlPannelMgr * (^)(CGRect rect))createAControlPannel;
- (YDAudioControlPannelMgr *(^)(UIColor *color))bgColor;


@end
