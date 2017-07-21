//
//  YDS3Mgr.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CBCharacteristic;

@interface YDS3Mgr : NSObject

+ (instancetype)shared;

- (void)insertDataToYDOpen:(CBCharacteristic *)characteristic;

@property (nonatomic, copy) void(^heartRateCallBack)(NSString *heartString);
@property (nonatomic, copy) void(^tripCallBack)(CGFloat calories, CGFloat distance);

@end
