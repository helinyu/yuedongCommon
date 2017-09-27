//
//  YDCircleSectionHeader.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDCircleSectionHeader : UICollectionReusableView

@property (nonatomic,   weak) UILabel *typeLabel;
@property (nonatomic,   weak) UIButton *checkMoreBtn;
@property (nonatomic,   weak) UIImageView *checkIcon;
@property (nonatomic,   weak) UIView *bottomView;
@property (nonatomic,   copy) void(^action)();


@end
