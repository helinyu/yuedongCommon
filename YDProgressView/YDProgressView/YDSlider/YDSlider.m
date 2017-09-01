//
//  YDLivePlaybackSlider.m
//  SportsBar
//
//  Created by 张旻可 on 23/02/2017.
//  Copyright © 2017 apple. All rights reserved.
//

#import "YDSlider.h"

@interface YDSlider ()

@property (nonatomic, assign) CGSize yd_thumbSize;

@end

@implementation YDSlider

- (instancetype)initWithThumbSize:(CGSize)size {
    self = [super init];
    if (self) {
        _yd_thumbSize = size;
    }
    return self;
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0, bounds.size.height / 2 - 1, bounds.size.width, 2);
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    CGFloat valueRatio = ( value - self.minimumValue ) / self.maximumValue;
    return CGRectMake(valueRatio *(bounds.size.width) - self.yd_thumbSize.width / 2, rect.origin.y - self.yd_thumbSize.height / 2 + rect.size.height / 2, self.yd_thumbSize.width, self.yd_thumbSize.height);
}


- (YDSlider *(^)(CGRect rect))ydFrame {
    return ^(CGRect rect) {
        self.frame = rect;
        return self;
    };
}

- (YDSlider *(^)(UIColor *color))ydThumbTintColor {
    return ^(UIColor *color) {
        self.thumbTintColor = color;
        return self;
    };
}

- (YDSlider *(^)(UIColor *color))ydMinimumTrackTintColor {
    return ^(UIColor *color) {
        self.minimumTrackTintColor = color;
        return self;
    };
}

- (YDSlider *(^)(UIColor *color))ydMaximumTrackTintColor {
    return ^(UIColor *color) {
        self.maximumTrackTintColor = color;
        return self;
    };
}

- (YDSlider *(^)(UIView *superView))ydSupperView {
    return ^(UIView *superView) {
        [superView addSubview:self];
        return self;
    };
}

@end
