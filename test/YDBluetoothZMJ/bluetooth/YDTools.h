//
//  YDTools.h
//  SportsBar
//
//  Created by 周取辉 on 14-5-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;

@interface YDTools : NSObject
@property(nonatomic,retain)NSDictionary *openDic;

+(YDTools *)shareTool;

//+(QiniuSimpleUploaderWrapper*) defaultQiniuSimpleUploader:(NSInteger) userId inActivity:(NSInteger) activityId withMd5:(NSString*) md5 bySource:(NSString*) source;
//
//+(QiniuSimpleUploaderWrapper*) defaultAudioQiniuSimpleUploader:(NSNumber *)userId andRunerID:(NSNumber *)runnerID withMd5:(NSString*) md5 bySource:(NSString*) source;

+(BOOL)isEmpty:(NSString*)strCheck;

+(CGRect) getWindowFrame;

+(NSString*)getCurrentTimeStr;
/**
 * 图片尺寸压缩
 */
+ (UIImage*)imageWithImageResize:(UIImage*)image scaledToSize:(CGSize)newSize;


/**
 * 图片压缩
 */
+ (NSString *)compressImage:(NSString *)imagePath;

/**
 * 打开相机
 */
+(UIImagePickerController *)openCameraWithIsAllowsEditing:(BOOL)isAllowsEditing;
/**
 *打开系统相册
 */
+(UIImagePickerController *)openSystemImageWithIsAllowsEditing:(BOOL)isAllowsEditing;



+(NSString*)getFormatTime:(NSInteger) time;

/**
 get a format string with "yyyy-M-d hh-mm" from date, if date is nil, return "2010-1-1 00:00";

 @param date the date

 @return formatter string
 */
+ (NSString *)formatDateStringWithDate:(NSDate *)date;

//请求推送的权限
+(void)requestPushPermission;

+(BOOL)isLogin;

+(NSString*)getLoginAccount;

+(NSString*)getLoginPassword;

#pragma mark - 保存图片至沙盒
+(NSString*) saveImage:(UIImage *)currentImage withName:(NSString *)imageName andCompressionQuality:(CGFloat)compressionQuality;
//删除
+(void)deleteDataWithPath:(NSString *)path;

+(void)setMainWindow:(UIWindow*)window;
+(UIWindow*)getMainWindow;

+(void)pushNotifyBackMianView;

//重定向日志
+(void)redirectNSLogToDocumentFolder;

+ (NSString *)getMacAddress;
+ (NSString*)getIDFA;

+ (NSDictionary *)getUmOnlineDic;

+ (BOOL)isMC;

+ (NSString *)getDeviceModel;//获取设备型号

+(NSString*)getVersion;

+(void)uploadDeviceToken;

+(void)reportLaunch;

+(NSDictionary *)getUrlDicWithUrl:(NSURL *)url;

+ (UIImage*) viewImageFromColors:(NSArray*)colors andViewRect:(CGRect)rect ByGradientType:(GradientType)gradientType;

//尺寸120x120
+(NSURL*) getUserHeadImg:(int)userId;

//尺寸 160x160
+(NSURL*) getUserBigHeadImg:(int)userId;

//尺寸 80x80
+(NSURL*) getUserSmallHeadImg:(int)userId;

+ (NSInteger)getPaceWithMileSpeed:(CGFloat)speed;

+ (NSString *)getPaceStringWithPace:(NSInteger)pace;
+ (NSString *)getPaceStringWithDistance:(NSNumber *)distance costTime:(NSNumber *)costTime;

+ (NSString *)getCostTimeStringWithCostTime:(NSNumber *)costTime;

#pragma mark--获取卡路里(千卡)
+(CGFloat)calorieWithDistance:(CGFloat)distance;

+(CGFloat)calorieWithCycleDistance:(CGFloat)distance;

+(CGFloat)distanceWithStep:(NSInteger)step;

+ (NSInteger)stepWithDistance:(CGFloat)distance;

+ (CGFloat)getStrideWithSpeed:(CGFloat)speed;

+ (UIImage *)screenShot: (CGRect)rect_ ofView: (UIView *)view_;
//+(NSString *)getIPWithHostName:(const NSString *)hostName;

+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type;

+ (void)handleImageView:(UIImageView *)iv WithUrl:(NSURL *)imageURL andImage:(UIImage *)image andType:(int)type;

+ (NSString *)rsaStringWithSource:(NSString *)source andKey:(NSString *)key;

+ (BOOL)isInstallRideApp;
@end
