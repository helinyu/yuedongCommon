//
//  S3ActivityView.m
//  YDOpenHardwareThirdPart
//
//  Created by felix on 2017/6/2.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "S3ActivityIndicatorView.h"

@interface S3ActivityIndicatorView()

@property (nonatomic, strong, readwrite) UIActivityIndicatorView *indicatorView;

@end

@implementation S3ActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)/2-30, CGRectGetHeight(frame)/2-30, 60, 60)];
        [self addSubview:self.indicatorView];
    }
    return self;
}

@end
