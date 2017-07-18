//
//  YDBlueToothMgr.h
//  test
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDBlueToothMgr : NSObject

+ (instancetype)shared;

/*
 * blue tooth search & filter key word and  pattern
 */
@property (nonatomic, copy) NSString *matchField;
@property (nonatomic, copy) NSString *prefixField;
@property (nonatomic, copy) NSString *suffixField;
@property (nonatomic, copy) NSString *containField;


@end
