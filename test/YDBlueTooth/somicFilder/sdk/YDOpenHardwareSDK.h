//
//  YDOpenHardwareSDK.h
//  YDOpenHardwareSDK
//
//  Created by 张旻可 on 16/2/2.
//  Copyright © 2016年 YD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//! Project version number for YDOpenHardwareSDK.
FOUNDATION_EXPORT double YDOpenHardwareSDKVersionNumber;

//! Project version string for YDOpenHardwareSDK.
FOUNDATION_EXPORT const unsigned char YDOpenHardwareSDKVersionString[];

static NSString *const YDNtfOpenHardwareAppdidFinishLaunch = @"YDNtfOpenHardwareAppdidFinishLaunch";
static NSString *const YDNtfOpenHardwareAppWillResignActive = @"YDNtfOpenHardwareAppWillResignActive";
static NSString *const YDNtfOpenHardwareAppDidEnterBackground = @"YDNtfOpenHardwareAppDidEnterBackground";
static NSString *const YDNtfOpenHardwareAppWillEnterForeground = @"YDNtfOpenHardwareAppWillEnterForeground";
static NSString *const YDNtfOpenHardwareAppDidBecomeActive = @"YDNtfOpenHardwareAppDidBecomeActive";
static NSString *const YDNtfOpenHardwareAppWillTerminate = @"YDNtfOpenHardwareAppWillTerminate";

// In this header, you should import all the public headers of your framework using statements like #import  PublicHeader.h>

#import "YDOpenHardwareManager.h"
#import  "YDOpenHardwareDataProvider.h"
#import  "YDOpenHardwareSDKDefine.h"
#import  "YDOpenHardwareHeartRate.h"
#import  "YDOpenHardwareIntelligentScale.h"
#import  "YDOpenHardwarePedometer.h"
#import  "YDOpenHardwareSleep.h"
#import  "YDOpenHardwareUser.h"

