//
//  CTDisplayView.h
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  YDCTModel;

//NSString *const CTDisplayViewImagePressedNotification = @"CTDisplayViewImagePressedNotification";
//NSString *const CTDisplayViewLinkPressedNotification = @"CTDisplayViewLinkPressedNotification";

@interface CTDisplayView : UIView

@property (strong, nonatomic) YDCTModel * data;

@end
