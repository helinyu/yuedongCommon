//
//  S3MianViewModel.m
//  YDOpenHardwareThirdPart
//
//  Created by mac-somic on 2017/4/18.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "S3MianViewModel.h"

@implementation S3MianViewModel

+ (NSString *)stringToNULL:(NSString *)string{
    if ([string isEqualToString:@"(null)"]) {
        string = @"0";
    }
    return string;
}

@end
