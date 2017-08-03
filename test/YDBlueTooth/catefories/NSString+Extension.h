//
//  NSString+Extension.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)


/*
 * @method : this method is to judge whether the str is in string or not
 * @discussion : because the containsString method is only use over the 8.f version
 * and we can user the YDString to compatible the version lower then 8.f;
 */
- (BOOL)containsString:(NSString *)str;

@end
