//
//  YDLivePlaybackSlider.m
//  SportsBar
//
//  Created by 张旻可 on 23/02/2017.
//  Copyright © 2017 apple. All rights reserved.
//

#import "YDAudioSlider.h"

@interface YDAudioSlider ()

@property (nonatomic, assign) CGSize yd_thumbSize;

@end

@implementation YDAudioSlider

- (instancetype)initWithThumbSize:(CGSize)size {
    self = [super init];
    if (self) {
        _yd_thumbSize = size;
    }
    return self;
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0,bounds.size.height/2 -2.5, bounds.size.width, 5);
}

-(UIImage *)_originImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}

- (YDAudioSlider *(^)(UIImage *img, CGSize size))customThumbImage {     __weak typeof (self) wSelf = self;
    return ^(UIImage *img, CGSize size) {
        UIImage *customImage = [wSelf _originImage:img scaleToSize:size];
        [wSelf setThumbImage:customImage forState:UIControlStateNormal];
        [wSelf setThumbImage:customImage forState:UIControlStateHighlighted];
        return self;
    };
}

- (YDAudioSlider *(^)(NSString *imgName, CGSize size))customThumbImageWithName {
    __weak typeof (self) wSelf = self;
    return ^(NSString *imgName, CGSize size) {
        UIImage *img = [UIImage imageNamed:imgName];
        wSelf.customThumbImage(img,size);
        return self;
    };
}

- (YDAudioSlider *(^)(CGRect rect))ydFrame {
    return ^(CGRect rect) {
        self.frame = rect;
        return self;
    };
}

- (YDAudioSlider *(^)(UIColor *color))ydThumbTintColor {
    return ^(UIColor *color) {
        self.thumbTintColor = color;
        return self;
    };
}

- (YDAudioSlider *(^)(UIColor *color))ydMinimumTrackTintColor {
    return ^(UIColor *color) {
        self.minimumTrackTintColor = color;
        return self;
    };
}

- (YDAudioSlider *(^)(UIColor *color))ydMaximumTrackTintColor {
    return ^(UIColor *color) {
        self.maximumTrackTintColor = color;
        return self;
    };
}

- (YDAudioSlider *(^)(UIView *superView))ydSupperView {
    return ^(UIView *superView) {
        [superView addSubview:self];
        return self;
    };
}

@end
