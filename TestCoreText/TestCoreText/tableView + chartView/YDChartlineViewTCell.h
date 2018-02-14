//
//  YDChartlineView.h
//  TestCoreText
//
//  Created by mac on 13/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDChartlineViewTCell : UITableViewCell

@property (nonatomic, copy) NSString *timeText;

@property (nonatomic, assign) CGFloat dotPoint;
@property (nonatomic, assign) CGFloat startPoint;
@property (nonatomic, assign) CGFloat endPoint;

- (void)configureStartPoint:(CGFloat)startPoint endPoint:(CGFloat)endPoint;
- (void)configureDotPoint:(CGFloat)dotPoint oneOfDoubleEndPoint:(CGFloat)oneEndPoint isStart:(BOOL)flag;
@end
