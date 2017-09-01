//
//  YDLivePlaybackSlider.h
//  SportsBar
//
//  Created by 张旻可 on 23/02/2017.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDSlider : UISlider

- (instancetype)initWithThumbSize:(CGSize)size;

- (YDSlider *(^)(CGRect rect))ydFrame;
- (YDSlider *(^)(UIColor *color))ydThumbTintColor;
- (YDSlider *(^)(UIColor *color))ydMinimumTrackTintColor;
- (YDSlider *(^)(UIColor *color))ydMaximumTrackTintColor;
- (YDSlider *(^)(UIView *superView))ydSupperView;


@end
