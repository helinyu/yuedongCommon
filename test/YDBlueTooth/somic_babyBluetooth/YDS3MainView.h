//
//  YDS3MainView.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YDActionType) {
    YDActionTypePeripheralList = 0,
    YDActionTypeStartBtn,
};

@interface YDS3MainView : UIView

@property (nonatomic, strong) UIButton *turnPeripheralListBtn;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UILabel *heartRateTitleLabel;
@property (nonatomic, strong) UILabel *heartRateNumLabel;
@property (nonatomic, strong) UILabel *calorieTitleLabel;
@property (nonatomic, strong) UILabel *calorieNumLabel;
@property (nonatomic, strong) UILabel *distancetitleLabel;
@property (nonatomic, strong) UILabel *distanceNumLabel;

@property (nonatomic, copy) void(^onBtnActionClicked)(YDActionType type);

@end
