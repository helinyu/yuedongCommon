//
//  YDTools.m
//  SportsBar
//
//  Created by 周取辉 on 14-5-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//
#import "YDTools.h"

#import "MSAppKit.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CoreMotion/CoreMotion.h>

//#include <arpa/inet.h>
//#include <netdb.h>
//#include <sys/socket.h>
#import "SDImageCache.h"
#import "SDWebImageManager.h"

#import "RSAEncryptor.h"

//#import "YDServerPushMgr.h"
//#import "MSUtil.h"

static UIWindow *_appWindow;

static YDTools *singleton;

@implementation YDTools




+(YDTools *)shareTool
{
    if (singleton == nil) {
        singleton = [[YDTools alloc]init];
    }
    return singleton;
}

//+(QiniuSimpleUploaderWrapper*) defaultQiniuSimpleUploader:(NSInteger) userId inActivity:(NSInteger) activityId withMd5:(NSString*) md5 bySource:(NSString*) source{
//    
//    NSURL *url = [NSURL yd_URLWithString:QINIU_UPTOKEN];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    
//    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
//    NSString *str = [[NSString alloc] initWithFormat:@"user_id=%ld&activity_id=%ld&md5=%@&qiniu_source=%@" ,(long)userId,(long)activityId,md5,source];
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:data];
//    
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    if (received != nil) {
//        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
//        
//        NSString* token = [dic objectForKey:@"up_token"];
//        
//        NSString* photoId = [dic objectForKey:@"photo_id"];
//        NSLog(@"photo id:%@",photoId);
//        
//        QiniuSimpleUploaderWrapper *simpleUploader =[QiniuSimpleUploaderWrapper uploaderWithToken:token];
//        
//        [simpleUploader setPhotoId:photoId];
//        
//        return simpleUploader;
//    }
//    return nil;
//}
//
//+(QiniuSimpleUploaderWrapper*) defaultAudioQiniuSimpleUploader:(NSNumber *)userId andRunerID:(NSNumber *)runnerID withMd5:(NSString*) md5 bySource:(NSString*) source{
//    
//    NSURL *url = [NSURL yd_URLWithString:QINIU_UPTOKEN];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
//    
//    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
//    NSString *str = [[NSString alloc] initWithFormat:@"user_id=%@&runner_id=%@&md5=%@&source=%@" ,userId,runnerID,md5,source];
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:data];
//    
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    if (received != nil) {
//        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
//        
//        NSString* token = [dic objectForKey:@"up_token"];
//        NSNumber* audioID = [dic objectForKey:@"photo_id"];
//        
//        QiniuSimpleUploaderWrapper *simpleUploader =[QiniuSimpleUploaderWrapper uploaderWithToken:token];
//        [simpleUploader setAudioID:audioID];
//        return simpleUploader;
//    }
//    return nil;
//}

+(BOOL)isEmpty:(NSString*)strCheck
{
    if (strCheck == nil || strCheck.length == 0) {
        return YES;
    }
    BOOL bRet = NO;
    NSString *str=[strCheck stringByReplacingOccurrencesOfString:@" " withString:@""];//去空格
    if (str == nil || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        bRet = YES;
    }
    return bRet;
}

+(CGRect) getWindowFrame{
    return _appWindow.frame;
}

+(NSString*)getCurrentTimeStr
{
    NSDate          *currentTime        =[[NSDate alloc]init];//获取当前时间
    NSDateFormatter *currentFormatter   =[[NSDateFormatter alloc]init];
    [currentFormatter setDateStyle:NSDateFormatterMediumStyle];
    [currentFormatter setTimeStyle:NSDateFormatterShortStyle];
    [currentFormatter setDateFormat:@"yyyy-MM-dd"];
    return [currentFormatter stringFromDate:currentTime];
}

/*
 * 打开摄像机
 */
+(UIImagePickerController *)openCameraWithIsAllowsEditing:(BOOL)isAllowsEditing
{
    UIImagePickerController *picker = nil;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        picker = [[UIImagePickerController alloc] init];
        //设置拍照后的图片可被编辑
        picker.allowsEditing = isAllowsEditing;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        picker.sourceType = sourceType;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }else{
//        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
    
    return picker;
}

//打开相册
+(UIImagePickerController *)openSystemImageWithIsAllowsEditing:(BOOL)isAllowsEditing
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //设置选择后的图片可被编辑
    picker.allowsEditing = isAllowsEditing;
    
    return picker;
}

//压缩图片
+ (UIImage*)imageWithImageResize:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


+ (NSString *)compressImage:(NSString*)imagePath
{
    UIImage * image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    float width_factor = image.size.width/300;
    CGSize newSize = CGSizeMake(image.size.width/width_factor, image.size.height/width_factor);
    
    UIImage * imageScaled = [YDTools imageWithImageResize:image scaledToSize:newSize];
    
    
    CGFloat copressScale = 0.75;
    NSData *data = UIImagePNGRepresentation(imageScaled);
    if (data != nil)
    {
#define MAX_JPG_LEN 100*1024
        if ([data length] > MAX_JPG_LEN)
        {
            copressScale  =0.50;
        }
        data = UIImageJPEGRepresentation(imageScaled, copressScale);
    }

//    NSLog(@"compress image %d %d",[UIImagePNGRepresentation(image) length],[data length]);
    
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * fileName =[NSString stringWithFormat:@"/%lld.png",(long long int)[[NSDate date] timeIntervalSince1970] ];
    
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:fileName] contents:data attributes:nil];
    
    return [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,fileName];
}


+(NSString*)getFormatTime:(NSInteger) time
{
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    
    NSDate* date =[NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"datetime.today.format";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *strTime = [formatter stringFromDate:date];
    return strTime;
    
}

+ (NSString *)formatDateStringWithDate:(NSDate *)date {
    if (!date) {
        return @"2010-1-1 00:00";
    }
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-M-d hh:mm";
    return [df stringFromDate:date];
}

//请求推送的权限
+(void)requestPushPermission
{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif

}

#pragma mark - 保存图片至沙盒
+(NSString*) saveImage:(UIImage *)currentImage withName:(NSString *)imageName andCompressionQuality:(CGFloat)compressionQuality
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, compressionQuality);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    return fullPath;
}

//删除
+(void)deleteDataWithPath:(NSString *)path//删除照片文件
{
    NSFileManager *fmanager=[[NSFileManager alloc]init];
    [fmanager removeItemAtPath:path error:Nil];
}

+(void)setMainWindow:(UIWindow *)window
{
    _appWindow = window;
}

+(UIWindow*)getMainWindow{
    return _appWindow;
}

+(void)pushNotifyBackMianView
{
//    YDBaseTabBarController *rootTabBarController=[[YDBaseTabBarController alloc]init];
//    [_appWindow setRootViewController:rootTabBarController];
//    [[[UIApplication sharedApplication] keyWindow] setRootViewController:rootTabBarController];
}

+(void)redirectNSLogToDocumentFolder
{
//    //如果已经连接Xcode调试则不输出到文件
//    if(isatty(STDOUT_FILENO)) {
//        return;
//    }
//    
//    UIDevice *device = [UIDevice currentDevice];
//    if([[device model] hasSuffix:@"Simulator"]){ //在模拟器不保存到文件中
//        return;
//    }
//    
//    //将NSlog打印信息保存到Document目录下的Log文件夹下
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//	BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
//    if (!fileExists) {
//		[fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
//	}
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //每次启动后都保存一个新的日志文件中
//    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
//    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/%@.log",dateStr];
//    
//    // 将log输入到文件
//    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
//    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    //未捕获的Objective-C异常日志
//    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

void UncaughtExceptionHandler(NSException* exception)
{
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ]; //将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [ strSymbols appendString: item ];
        [ strSymbols appendString: @"\r\n" ];
    }
    
    //将crash日志保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
		[fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
	}
    
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.log"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]\r\n\r\n", dateStr, name, reason, strSymbols];
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    
    //把错误日志发送到邮箱
    //    NSString *urlStr = [NSString stringWithFormat:@"mailto://test@163.com?subject=bug报告&body=感谢您的配合!<br><br><br>错误详情:<br>%@",crashString ];
    //    NSURL *url = [NSURL yd_URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    [[UIApplication sharedApplication] openURL:url];
}


+ (NSString*)getIDFA{
    
    return [MSAppKit getIDFA];
}


+ (NSString *)getMacAddress
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    if ((buf = (char *)malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
//    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}
//+ (NSDictionary *)getUmOnlineDic
//{
//    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
//    NSDictionary *umOnlineDic = [userdf objectForKey:UM_ONLINE_DIC];
//    return umOnlineDic;
//}

+ (BOOL)isMC
{
    if (!([CMStepCounter isStepCountingAvailable] || [CMMotionActivityManager isActivityAvailable])) {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (NSString *)getDeviceModel//获取设备型号
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    return platform;
}

+(NSString*)getVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return version;
}

+(void)uploadDeviceToken
{
    NSUserDefaults *userDEFAULTs = [NSUserDefaults standardUserDefaults];
    NSString *pushToken = (NSString*)[userDEFAULTs objectForKey:@"push_token"];
    
//    UserModel *userModel = [UserModel shareUserModel];
//    if (pushToken.length > 0 && userModel.userID != nil) {
//        [[YDUserInstance sportMgr] pusherIndexIosOfMid: 6 param: [YDDataSolver pusherIndexIos: userModel.userID device_token: pushToken]];
//    }
}

+(void)reportLaunch {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *device_token = [userDefaults stringForKey:@"push_token"];
//    if (device_token.length && [YDAppInstance hasUserId]) {
//        [[YDUserInstance serverPushMgr] reportLaunchNotifyType:@6 typeName:@"umeng" deviceToken:device_token];
//    }
}

//+(NSDictionary *)getUrlDicWithUrl:(NSURL *)url
//{
//    return [MSUtil queryDicFromUrl:url];
//}


+ (UIImage*) viewImageFromColors:(NSArray*)colors andViewRect:(CGRect)rect ByGradientType:(GradientType)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, rect.size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(rect.size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(rect.size.width, rect.size.height);
            break;
        case 3:
            start = CGPointMake(rect.size.width, 0.0);
            end = CGPointMake(0.0, rect.size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}
//
//+(NSURL*)getUserBigHeadImg:(int)userId{
//
//    NSURL *headImgUrl = [NSURL yd_URLWithString:[NSString stringWithFormat:[YDURL HEAD_URL], [NSString stringWithFormat:@"%d", userId], 160]];
//
//    return headImgUrl;
//}
//
//+(NSURL*)getUserHeadImg:(int)userId{
//    NSURL *headImgUrl = [NSURL yd_URLWithString:[NSString stringWithFormat:[YDURL HEAD_URL], [NSString stringWithFormat:@"%d", userId], 120]];
//
//    return headImgUrl;
//}
//
//+(NSURL*)getUserSmallHeadImg:(int)userId{
//    NSURL *headImgUrl = [NSURL yd_URLWithString:[NSString stringWithFormat:[YDURL HEAD_URL], [NSString stringWithFormat:@"%d", userId], 80]];
//
//    return headImgUrl;
//}

+ (NSInteger)getPaceWithMileSpeed:(CGFloat)speed{
    if (speed >= 0) {
        CGFloat meterSpeed = speed*1000/3600.0f;
        CGFloat pace = 1000/meterSpeed;
        return (NSInteger)pace;
    }
    else{
        return 0;
    }
}

+ (NSString *)getPaceStringWithPace:(NSInteger)pace{
    NSString *paceStr;
    if(pace/60<60 || pace==3600)
    {
        paceStr=[NSString stringWithFormat:@"%@'%02ld\"",@(pace/60),(long)pace%60];
    }
    else
    {
        paceStr=@">60'00\"";
    }
    return paceStr;
}

+ (NSString *)getPaceStringWithDistance:(NSNumber *)distance costTime:(NSNumber *)costTime {
    NSString *speedStr = nil;
    if (distance.floatValue > 0.01) {
        NSInteger speed = (costTime.floatValue / distance.floatValue ) * 1000;
        if(speed / 60 < 60 || speed == 3600) {
            speedStr = [NSString stringWithFormat:@"%ld'%02ld\"", (long)speed / 60, (long)speed % 60];
        } else {
            speedStr = @">60'";
        }
    } else {
        speedStr = @"00'00\"";
    }
    return speedStr;
}

+ (NSString *)getCostTimeStringWithCostTime:(NSNumber *)costTime {
    NSInteger hour = costTime.integerValue / 3600;
    NSInteger minute = (costTime.integerValue % 3600) / 60;
    NSInteger second = costTime.integerValue % 60;
    if (hour) {
        return [NSString stringWithFormat:@"%ld:%02ld:%02ld", (long)hour, (long)minute, (long)second];
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minute, (long)second];
    }
}

+(CGFloat)calorieWithDistance:(CGFloat)distance
{
//    NSNumber *personWeight = nil;
//    if ([YDUserInstance getAccount].height.integerValue) {
//        personWeight = [YDUserInstance getAccount].weight;
//    } else {
//        personWeight = [[NSUserDefaults standardUserDefaults] objectForKey:PERSON_WEIGHT];
//    }
//
//    if (personWeight == nil) {
//        personWeight = [NSNumber numberWithInteger:50];
//    }
    
    return 1.306*(distance/1000.0)*60.f;
}

/**
卡路里计算公式:骑车距离（m）*体重（70kg,如果有用户体重信息则取用户体重数值）*9.8（重力系数）
*0.18（摩擦系数）/4200                1卡路里=4200焦耳
 9.8*0.18/4200 = 0.00042;
*/
+(CGFloat)calorieWithCycleDistance:(CGFloat)distance
{
    NSNumber *personWeight = nil;
//    if ([YDUserInstance getAccount].height.integerValue) {
//        personWeight = [YDUserInstance getAccount].weight;
//    } else {
//        personWeight = [[NSUserDefaults standardUserDefaults] objectForKey:PERSON_WEIGHT];
//    }
    
    if (personWeight == nil) {
        personWeight = [NSNumber numberWithInteger:50];
    }
    CGFloat calorie = distance * personWeight.floatValue * 0.00042;
    return calorie;
}

+(CGFloat)distanceWithStep:(NSInteger)step{
    NSNumber *heightNum = nil;
//    if ([YDUserInstance getAccount].height.integerValue) {
//        heightNum = [YDUserInstance getAccount].height;
//    } else {
//        heightNum = [[NSUserDefaults standardUserDefaults] objectForKey:PERSON_HEIGHT];
//    }
    if (heightNum == nil) {
        heightNum = [NSNumber numberWithFloat:170.0f];
    }
    NSNumber *basicStepDistance = [[[NSUserDefaults standardUserDefaults] objectForKey:@"um_online_dic"] objectForKey:@"basic_step_distance"];
    if (basicStepDistance == nil) {
        basicStepDistance = [NSNumber numberWithFloat:0.65];
    }
    return step * heightNum.floatValue/170.0f * basicStepDistance.floatValue;
}

+ (NSInteger)stepWithDistance:(CGFloat)distance{
    NSNumber *heightNum = nil;
//    if ([YDUserInstance getAccount].height.integerValue) {
//        heightNum = [YDUserInstance getAccount].height;
//    } else {
//        heightNum = [[NSUserDefaults standardUserDefaults] objectForKey:PERSON_HEIGHT];
//    }
    if (heightNum == nil) {
        heightNum = [NSNumber numberWithFloat:170.0f];
    }
    NSNumber *basicStepDistance = [[[NSUserDefaults standardUserDefaults] objectForKey:@"um_online_dic"] objectForKey:@"basic_step_distance"];
    if (basicStepDistance == nil) {
        basicStepDistance = [NSNumber numberWithFloat:0.65];
    }
    return (NSInteger)(distance/(heightNum.floatValue/170.0f * basicStepDistance.floatValue));
}

+ (CGFloat)getStrideWithSpeed:(CGFloat)speed {
    NSNumber *heightNum = nil;
//    if ([YDUserInstance getAccount].height.integerValue) {
//        heightNum = [YDUserInstance getAccount].height;
//    } else {
//        heightNum = [[NSUserDefaults standardUserDefaults] objectForKey:PERSON_HEIGHT];
//    }
    if (!heightNum) {
        heightNum = @(170);
    }
    NSInteger height = heightNum.integerValue;
    int nStrideLength = 62;
    if (height < 50){
        height = 50;
    }else if (height > 190){
        height = 190;
    }else{
        if (0 == height % 10){
            height = (height / 10) % 10;
        }else{
            height = (height / 10 + 1) * 10;
        }
    }
    switch (height){
        case 50:{
            nStrideLength = 20;
            break;
        }
        case 60:{
            nStrideLength = 22;
            break;
        }
        case 70:{
            nStrideLength = 25;
            break;
        }
        case 80:{
            nStrideLength = 29;
            break;
        }
        case 90:{
            nStrideLength = 33;
            break;
        }
        case 110:{
            nStrideLength = 40;
            break;
        }
        case 120:{
            nStrideLength = 44;
            break;
        }
        case 130:{
            nStrideLength = 48;
            break;
        }
        case 150:{
            nStrideLength = 55;
            break;
        }
        case 160:{
            nStrideLength = 59;
            break;
        }
        case 170:{
            nStrideLength = 62;
            break;
        }
        case 180:{
            nStrideLength = 66;
            break;
        }
        case 190:{
            nStrideLength = 70;
            break;
        }
        default:
            break;
    }
    return nStrideLength * (1 + speed / 25);
}

+ (UIImage *)screenShot: (CGRect)rect_ ofView: (UIView *)view_ {
    CGSize size = CGSizeMake(rect_.size.width, rect_.size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [view_ drawViewHierarchyInRect: rect_ afterScreenUpdates: YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
 +(NSString *)getIPWithHostName:(const NSString *)hostName
 {
 const char *hostN= [hostName UTF8String];
 struct hostent* phot;
 
 @try {
 phot = gethostbyname(hostN);
 
 }
 @catch (NSException *exception) {
 return nil;
 }
 struct in_addr ip_addr;
 memcpy(&ip_addr, phot->h_addr_list[0], 4);
 char ip[20] = {0};
 inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
 
 NSString* strIPAddress = [NSString stringWithUTF8String:ip];
 return strIPAddress;
 }
 */

+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type {
    
    CGImageRef imageRef = anImage.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data);
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8 *tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            switch (type) {
                case 1:
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                case 2:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                case 3:
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
        }
    }
    
    
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    CGImageRelease(effectedCgImage);
    
    CFRelease(effectedDataProvider);
    
    CFRelease(effectedData);
    
    CFRelease(data);
    
    return effectedImage;
    
}

+ (void)handleImageView:(UIImageView *)iv WithUrl:(NSURL *)imageURL andImage:(UIImage *)image andType:(int)type{
    NSString* key = [[SDWebImageManager sharedManager] cacheKeyForURL:imageURL];
    BOOL result = [[SDImageCache sharedImageCache] diskImageExistsWithKey:key];
    NSString* imagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:key];
    NSData* newData = [NSData dataWithContentsOfFile:imagePath];
    if (!result || !newData) {
        BOOL imageIsPng = ImageDataHasPNGPreffix(newData);
        NSData* imageData = nil;
        if (imageIsPng) {
            imageData = UIImagePNGRepresentation(image);
        }
        else {
            imageData = UIImageJPEGRepresentation(image, (CGFloat)1.0);
        }
        NSFileManager* _fileManager = [NSFileManager defaultManager];
        if (imageData) {
            [_fileManager removeItemAtPath:imagePath error:nil];
            [_fileManager createFileAtPath:imagePath contents:imageData attributes:nil];
        }
    }
    newData = [NSData dataWithContentsOfFile:imagePath];
    UIImage* grayImage = nil;
    if (type == 0) {
        grayImage = [UIImage imageWithData:newData];
    }else{
        UIImage* newImage = [UIImage imageWithData:newData];
        
        grayImage = [YDTools grayscale:newImage type:type];
    }
    iv.image = grayImage;
}


static NSData *kPNGSignatureData = nil;

BOOL ImageDataHasPNGPreffix(NSData *data);

BOOL ImageDataHasPNGPreffix(NSData *data) {
    NSUInteger pngSignatureLength = [kPNGSignatureData length];
    if ([data length] >= pngSignatureLength) {
        if ([[data subdataWithRange:NSMakeRange(0, pngSignatureLength)] isEqualToData:kPNGSignatureData]) {
            return YES;
        }
    }
    return NO;
}


+ (NSString *)rsaStringWithSource:(NSString *)source andKey:(NSString *)key {
    RSAEncryptor *rsa = [[RSAEncryptor alloc] init];
    [rsa loadPublicKeyFromFile:key];
    NSString *es = [rsa rsaEncryptString:source];
    return es;
}

+ (BOOL)isInstallRideApp {
    NSURL *installURL = [NSURL URLWithString:@"yodoRide://"];
    BOOL hasInstall = [[UIApplication sharedApplication] canOpenURL:installURL];
    return hasInstall;
}

@end
