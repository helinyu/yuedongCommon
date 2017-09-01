//
//  YDControlPannelController.h
//  SportsBar
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDControlPannelController : UIViewController

- (YDControlPannelController *(^)(NSString *title))controlPanelTitle;
- (YDControlPannelController *(^)(NSInteger currentTime))controlPanelCurrentTime;
- (YDControlPannelController *(^)(NSInteger leaveTime))controlPanelLeaveTime;
- (YDControlPannelController *(^)(NSInteger totalTime))controlPanelTotalTime;
- (YDControlPannelController *(^)(void))controlPanelNext;
- (YDControlPannelController *(^)(void))controlPanelPrevious;
- (YDControlPannelController *(^)(CGFloat progress))controlPanelProgress;

@end
