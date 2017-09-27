//
//  YDCircleBannerView.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCircleBannerView.h"
#import "SDCycleScrollView.h"

@interface YDCircleBannerView ()

@property (nonatomic, strong, readwrite) SDCycleScrollView *scrollView;

@end
@implementation YDCircleBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:nil];
        [self addSubview:self.scrollView];
        if (self.scrollView) {
            [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }
    return self;
}


@end
