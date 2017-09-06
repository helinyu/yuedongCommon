//
//  BluetoothDaterView.h
//  SOMICS3
//
//  Created by mac-somic on 2017/4/17.
//  Copyright © 2017年 mac-somic. All rights reserved.
//

#ifdef DEBUG
#define ZFLog(...) NSLog(__VA_ARGS__)
#else
#define ZFLog(...)
#endif

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a/1.0]
#define RGB(A, B, C)        [UIColor colorWithRed:(A)/255.0 green:(B)/255.0 blue:(C)/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ImageName(name) [UIImage imageNamed:name]
#define Font(x) [UIFont systemFontOfSize:x]
#define Frame(x,y,w,h) CGRectMake(x, y, w, h)
#define Size(w,h) CGSizeMake(w, h)
#define Point(x,y) CGPointMake(x, y)
#define ZeroRect CGRectZero
#define TouchUpInside UIControlEventTouchUpInside
#define NormalState UIControlStateNormal
#define SelectedState UIControlStateSelected
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define WH(x) (x)*SCREEN_WIDTH/375.0
#define MainRedColor RGB(225,62,63)
#define MainGreenColor RGB(28,192,25)
#define BlackFontColor RGB(34,34,34)
#define WhiteColor RGB(255,255,255)
#define ContentBackGroundColor RGB(238,238,238)

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BluetoothDaterViewType){
    BluetoothDaterViewTypeDate = 0,//年月日
    BluetoothDaterViewTypeTime ,//时分秒
};

@class BluetoothDaterView;

@protocol BluetoothDaterViewDelegate <NSObject>

- (void)daterViewDidClicked:(BluetoothDaterView *)daterView;
- (void)daterViewDidCancel:(BluetoothDaterView *)daterView;

@end

@interface BluetoothDaterView : UIView

@property (nonatomic, weak) id<BluetoothDaterViewDelegate> delegate;

@property (nonatomic) BluetoothDaterViewType dateViewType;//默认类型为日期
@property (nonatomic) NSString *dateString;
@property (nonatomic) NSString *timeString;
@property (nonatomic, readonly) int year;
@property (nonatomic, readonly) int month;
@property (nonatomic, readonly) int day;
@property (nonatomic, readonly) int hour;
@property (nonatomic, readonly) int miniute;
@property (nonatomic, readonly) int second;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

- (void)setSelectYear:(int)year month:(int)month day:(int)day animated:(BOOL)animated;

@end