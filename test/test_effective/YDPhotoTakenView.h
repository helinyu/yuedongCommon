//
//  YDPhotoTakenView.h
//  test_effective
//
//  Created by Aka on 2017/11/11.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface YDPhotoTakenView : UIView

- (void)takePhotoThen:(void(^)(NSData *imgData,UIImage *img))then;

- (void)toggleCamera;

- (void)stopRunning;
- (void)startRunning;
- (void)toggleRunning;

@end
