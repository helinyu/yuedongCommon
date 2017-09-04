//
//  YDControlPannelController.h
//  SportsBar
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDAudioDefine.h"

@interface YDControlPannelController : UIViewController

@property (nonatomic, copy) VoidBlcok closeBlock;
@property (nonatomic, copy) FloatBlock changeValueBlock;
@property (nonatomic, copy) VoidBlcok nextBlock;
@property (nonatomic, copy) VoidBlcok previousBlock;
@property (nonatomic, copy) VoidBlcok playOrPauseBlock;

- (YDControlPannelController *(^)(NSString *title))controlPanelTitle;
- (YDControlPannelController *(^)(NSTimeInterval currentTime))controlPanelCurrentTime;
- (YDControlPannelController *(^)(NSTimeInterval totalTime))controlPanelTotalTime;

- (YDControlPannelController *(^)(BOOL isPlaying))updatePlayOrPause;

- (YDControlPannelController *(^)(void))updateView;


@end
