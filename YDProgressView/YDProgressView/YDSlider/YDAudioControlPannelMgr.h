//
//  YDAudioControlPannelMgr.h
//  SportsBar
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YDAudioDefine.h"
@class YDPannelINfo;

@interface YDAudioControlPannelMgr : NSObject


+ (instancetype)shared;

- (YDAudioControlPannelMgr * (^)(CGRect rect))createAControlPannel;
- (YDAudioControlPannelMgr *(^)(UIColor *color))bgColor;

- (BOOL)hasCreate;
- (BOOL)isPannelHidden;

- (YDAudioControlPannelMgr *(^)(BOOL hidden))hideHoverPannel;

- (void)updateViewWithInfo:(YDPannelINfo *)info;// update all the changeable control
- (void)updateProgressViewWithInfo:(YDPannelINfo *)info ;  // update the control which relavent to the progress

@end