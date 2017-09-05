//
//  YDLivePlaybackSlider.h
//  SportsBar
//
//  Created by 张旻可 on 23/02/2017.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDAudioDefine.h"

@interface YDAudioSlider : UISlider

- (instancetype)initWithThumbSize:(CGSize)size;

- (YDAudioSlider *(^)(CGRect rect))ydFrame;
- (YDAudioSlider *(^)(UIColor *color))ydThumbTintColor;
- (YDAudioSlider *(^)(UIColor *color))ydMinimumTrackTintColor;
- (YDAudioSlider *(^)(UIColor *color))ydMaximumTrackTintColor;
- (YDAudioSlider *(^)(UIView *superView))ydSupperView;

- (YDAudioSlider *(^)(UIImage *img, CGSize size))customThumbImage;
- (YDAudioSlider *(^)(NSString *imgName, CGSize size))customThumbImageWithName;

@property (nonatomic, copy) FloatBlock valueChangeBlock;
@property (nonatomic, copy) VoidBlcok valueBeginChagneBlock;

@end
