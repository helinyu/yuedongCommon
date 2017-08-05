//
//  MSAppKit.m
//  SportsInternational
//
//  Created by 张旻可 on 15/8/28.
//  Copyright (c) 2015年 yuedong. All rights reserved.
//

#import "MSAppKit.h"
#import <sys/sysctl.h>
#import <AdSupport/AdSupport.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/task_info.h>
#import <mach/task.h>
#import <mach/mach.h>
#import "MSStringKit.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Reachability.h"
#import <StoreKit/StoreKit.h>

@implementation MSAppKit

+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    //NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    //NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    if (appVersion == nil) {
        return @"unknown";
    } else {
        return appVersion;
    }
}

+ (NSString *)getAppChannel {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *channel = [infoDic objectForKey: @"Channel"];
    if (!channel) {
        channel = @"AppStore";
    }
    return channel;
}

+ (NSString *)getDeviceModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString: machine encoding: NSUTF8StringEncoding];
    free(machine);
    if (!platform.length) {
        platform = @"unknown";
    }
    return platform;
}
+ (NSString *)getDeviceName {
    NSString *platform = [self getDeviceModel];
    return [self platformString: platform];
}

+ (NSString *)getOSVersion {
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    if (!osVersion) {
        osVersion = @"unknown";
    }
    return osVersion;
}

+ (NSString *)getIDFA {
#if (TARGET_IPHONE_SIMULATOR)
    // 在模拟器的情况下
    return @"AB307C39-FCD7-40A9-A413-00717D09E797";
#else
    NSString *idfa = [self getRealIDFA];
    if (idfa) {
        return [NSString stringWithFormat:@"idfa_%@", idfa];
    } else {
        NSString * currentDeviceUUIDStr = nil;
        //    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
        //    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        //    currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr uppercaseString];
        //        [SSKeychain setPassword: currentDeviceUUIDStr forService:@" "account:@"uuid"];
        //    }
        return [NSString stringWithFormat:@"idfv_%@", currentDeviceUUIDStr];
    }
    
#endif

}

+ (NSString *)getRealIDFA {
    NSBundle*adSupportBundle = [NSBundle bundleWithPath: @"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];

    if (adSupportBundle == nil) {
        return nil;
    } else {

        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");

        if ( asIdentifierMClass == nil) {
            return nil;
        } else {
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];

            if(asIM == nil){
                return nil;
            }
            else{

                if (asIM.advertisingTrackingEnabled) {

                }
                else{
                }
                NSString *idfa = [asIM.advertisingIdentifier UUIDString];
                if (!idfa) {
                    return nil;
                } else if ([MSStringKit isInvalidIDFA:idfa]) {
                    return nil;
                } else {
                    return idfa;
                }
            }
        }
    }
}

+ (NSString *)getMacAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return nil;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return nil;
    }
    
    if ((buf = (char *)malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return nil;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)getBundleID {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    //NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *appBundleID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    // app build版本
    //NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    if (appBundleID == nil) {
        return @"unknown";
    } else {
        return appBundleID;
    }
}

+ (NSString *)platformString: (NSString *)deviceModel;
{
    NSString *platform = deviceModel;
    NSDictionary *dic = @{@"i386"      :@"Simulator",
                          @"x86_64"    :@"Simulator",
                          @"iPod1,1"   :@"iPodTouch",        // (Original)
                          @"iPod2,1"   :@"iPodTouch",        // (Second Generation)
                          @"iPod3,1"   :@"iPodTouch",        // (Third Generation)
                          @"iPod4,1"   :@"iPodTouch",        // (Fourth Generation)
                          @"iPod7,1"   :@"iPodTouch",        // (6th Generation)
                          @"iPhone1,1" :@"iPhone",            // (Original)
                          @"iPhone1,2" :@"iPhone",            // (3G)
                          @"iPhone2,1" :@"iPhone",            // (3GS)
                          @"iPad1,1"   :@"iPad",              // (Original)
                          @"iPad2,1"   :@"iPad2",            //
                          @"iPad3,1"   :@"iPad",              // (3rd Generation)
                          @"iPhone3,1" :@"iPhone4",          // (GSM)
                          @"iPhone3,3" :@"iPhone4",          // (CDMA/Verizon/Sprint)
                          @"iPhone4,1" :@"iPhone4S",         //
                          @"iPhone5,1" :@"iPhone5",          // (model A1428, AT&T/Canada)
                          @"iPhone5,2" :@"iPhone5",          // (model A1429, everything else)
                          @"iPad3,4"   :@"iPad",              // (4th Generation)
                          @"iPad2,5"   :@"iPadMini",         // (Original)
                          @"iPhone5,3" :@"iPhone5c",         // (model A1456, A1532 | GSM)
                          @"iPhone5,4" :@"iPhone5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                          @"iPhone6,1" :@"iPhone5s",         // (model A1433, A1533 | GSM)
                          @"iPhone6,2" :@"iPhone5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                          @"iPhone7,1" :@"iPhone6Plus",     //
                          @"iPhone7,2" :@"iPhone6",          //
                          @"iPhone8,1" :@"iPhone6S",         //
                          @"iPhone8,2" :@"iPhone6SPlus",    //
                          @"iPhone8,4" :@"iPhoneSE",         //
                          @"iPhone9,1" :@"iPhone7",
                          @"iPhone9,2" :@"iPhone7Plus",
                          @"iPhone9,3" :@"iPhone7",
                          @"iPhone9,4" :@"iPhone7Plus",
                          @"iPad4,1"   :@"iPadAir",          // 5th Generation iPad (iPad Air) - Wifi
                          @"iPad4,2"   :@"iPadAir",          // 5th Generation iPad (iPad Air) - Cellular
                          @"iPad4,4"   :@"iPadMini",         // (2nd Generation iPad Mini - Wifi)
                          @"iPad4,5"   :@"iPadMini",         // (2nd Generation iPad Mini - Cellular)
                          @"iPad4,7"   :@"iPadMini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                          @"iPad6,7"   :@"iPadPro(12.9)", // iPad Pro 12.9 inches - (model A1584)
                          @"iPad6,8"   :@"iPadPro(12.9)", // iPad Pro 12.9 inches - (model A1652)
                          @"iPad6,3"   :@"iPadPro(9.7)",  // iPad Pro 9.7 inches - (model A1673)
                          @"iPad6,4"   :@"iPadPro(9.7)"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                          };
    NSString *name = [dic objectForKey: platform];
    if (name == nil) {
        name = platform;
    }
    if (name == nil) {
        name = @"unknown";
    }
    return name;
}

+ (CGFloat)GetCurrentTaskUsedMemory {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    return taskInfo.resident_size;
}

+ (BOOL)hasHeadset {
//#if TARGET_IPHONE_SIMULATOR
//#warning *** Simulator mode: audio session code works only on a device
//    return NO;
//#else
//    CFStringRef route;
//    UInt32 propertySize = sizeof(CFStringRef);
//    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &propertySize, &route);
//    if((route == NULL) || (CFStringGetLength(route) == 0)){
//        // Silent Mode
////        NSLog(@"AudioRoute: SILENT, do nothing!");
//    } else {
//        NSString* routeStr = (__bridge NSString*)route;
////        NSLog(@"AudioRoute: %@", routeStr);
//        /* Known values of route:
//         * "Headset"
//         * "Headphone"
//         * "Speaker"
//         * "SpeakerAndMicrophone"
//         * "HeadphonesAndMicrophone"
//         * "HeadsetInOut"
//         * "ReceiverAndMicrophone"
//         * "Lineout"
//         */
//        NSRange headphoneRange = [routeStr rangeOfString : @"Head"];
//        
//        if (headphoneRange.location != NSNotFound) return YES;
////        NSRange headphoneRange = [routeStr rangeOfString : @"Headphone"];
////        NSRange headsetRange = [routeStr rangeOfString : @"Headset"];
////        if (headphoneRange.location != NSNotFound) {
////            return YES;
////        } else if(headsetRange.location != NSNotFound) {
////            return YES;
////        }
//    }
    return NO;
//#endif
}

+ (NSNumber *)getDevicePixelWidth {
    return @([UIScreen mainScreen].bounds.size.width * [self getDeviceScale]);
}
+ (NSNumber *)getDevicePixelHeight {
    return @([UIScreen mainScreen].bounds.size.height * [self getDeviceScale]);
}
+ (CGFloat)getDeviceScale {
    return [UIScreen mainScreen].scale;
}
+ (NSNumber *)getCarrierId {
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
//    NSString *currentCountry=[carrier carrierName];
//    NSLog(@"[carrier isoCountryCode]==%@,[carrier allowsVOIP]=%d,[carrier mobileCountryCode=%@,[carrier mobileCountryCode]=%@",[carrier isoCountryCode],[carrier allowsVOIP],[carrier mobileCountryCode],[carrier mobileNetworkCode]);
    
    return @([carrier mobileNetworkCode].integerValue);
}
+ (NSNumber *)getCarrierIdForAd360 {
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    UIView *serviceView = nil;
    Class serviceClass = NSClassFromString([NSString stringWithFormat:@"UIStat%@Serv%@%@", @"usBar", @"ice", @"ItemView"]);
    for (UIView *subview in subviews) {
        if([subview isKindOfClass:[serviceClass class]]) {
            serviceView = subview;
            break;
        }
    }
    if (serviceView) {
        NSString *carrierName = [serviceView valueForKey:[@"service" stringByAppendingString:@"String"]];
        if ([carrierName rangeOfString:@"联通"].length > 0 || [[carrierName lowercaseString] rangeOfString:@"unicom"].length > 0) {
            return @(70123);
        } else if ([carrierName rangeOfString:@"电信"].length > 0 || [[carrierName lowercaseString] rangeOfString:@"telecom"].length > 0) {
            return @(70121);
        } else if ([carrierName rangeOfString:@"移动"].length > 0 || [[carrierName lowercaseString] rangeOfString:@"mobile"].length > 0) {
            return @(70120);
        }
    }
    return @(0);
}
+ (NSNumber *)getNetworkTypeForAd360 {
    NetworkStatus status = [Reachability reachabilityForInternetConnection].currentReachabilityStatus;
    if (status == NotReachable) {
        return @0;
    } else if (status == ReachableViaWWAN) {
        return @2;
    } else if (status == ReachableViaWiFi) {
        return @1;
    }
    return @0;
}

+ (NSString *)getBrowserUserAgent {
    UIWebView *webView = [[UIWebView alloc] initWithFrame: CGRectZero];
    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    if (!userAgent.length) {
        userAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 8_3_1 like Mac OS X) ";
    }
    return userAgent;
}

@end
