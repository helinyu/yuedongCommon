//
//  MSAppKit.h
//  SportsInternational
//
//  Created by 张旻可 on 15/8/28.
//  Copyright (c) 2015年 yuedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAppKit : NSObject

+ (NSString *)getAppVersion;
+ (NSString *)getAppChannel;
+ (NSString *)getDeviceModel;
+ (NSString *)getDeviceName;
+ (NSString *)getOSVersion;
+ (NSString *)getIDFA;
+ (NSString *)getMacAddress;
+ (NSString *)getBundleID;
+ (NSNumber *)getDevicePixelWidth;
+ (NSNumber *)getDevicePixelHeight;
//+ (CGFloat)getDeviceScale;
+ (NSNumber *)getCarrierId;
+ (NSNumber *)getCarrierIdForAd360;
+ (NSNumber *)getNetworkTypeForAd360;
+ (NSString *)getBrowserUserAgent;
//+ (CGFloat)GetCurrentTaskUsedMemory;
+ (BOOL)hasHeadset;

@end
