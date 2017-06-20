//
//  HLYPicStatusView.m
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYPicStatusView.h"
#import "HLYBackdropModel.h"

@interface HLYPicStatusView ()

@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UIView *progressView;

@end

@implementation HLYPicStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit:frame];
    }
    return self;
}

- (void)comInit:(CGRect)frame {
    
    self.backgroundColor = [UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:0.9f];
    
    _progressView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_progressView];
    _progressView.backgroundColor = [UIColor colorWithRed:17.f/255.f green:211.f/255.f blue:154.f/255.f alpha:1.f];
    
    _statusImageView = [UIImageView new];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    _statusImageView.frame = CGRectMake((width-height)/2.f, 0, height, height);
    
    [self addSubview:_statusImageView];
    
}

- (void)configureStatusWithItem:(HLYBackdropOnlineModel *)item {
    _statusImageView.image = [UIImage imageNamed:item.statusImageUrl];
    _progressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)*item.progress, CGRectGetHeight(self.bounds));
    
}

@end
