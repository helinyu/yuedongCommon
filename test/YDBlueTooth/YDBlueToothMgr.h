//
//  YDBlueToothMgr.h
//  test
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBPeripheral;

typedef NS_ENUM(NSInteger, YDBlueToothFilterType) {
    YDBlueToothFilterTypeMatch = 0,  // match to filter and find the specify device
    YDBlueToothFilterTypeContain,    // contain the keyword to filter and find the specify device
    YDBlueToothFilterTypePrefix,     // key word by the prefix
    YDBlueToothFilterTypeSuffix,     // key word by the suffix
    YDBlueToothFilterTypePrefixAndSuffix, // key word by the prefix & suffix
    YDBlueToothFilterTypePrefixAndContain, // key word by the prefix & contain
    YDBlueToothFilterTypeSuffixAndContrain, // key word by the suffix & contain
    YDBlueToothFilterTypePrefixAndContrainAndSuffix, //key word by the prefix & contrain * suffix
};

@interface YDBlueToothMgr : NSObject

+ (instancetype)shared;

- (void)startScan;

/*
 * blue tooth search & filter key word and  pattern
 */
@property (nonatomic, copy) NSString *matchField;
@property (nonatomic, copy) NSString *prefixField;
@property (nonatomic, copy) NSString *suffixField;
@property (nonatomic, copy) NSString *containField;

/*
 * param : filterType
 * discussion : filter determine which type we will use to filter and find the specify bluetooth
 */
@property (nonatomic, assign) YDBlueToothFilterType filterType;

/*
 * param : peripherals , memory store peripheral to display & for selected
 * discussion : this attribute must be implement for selected and search service enable by it ,if not ,it will be not find the services
 */
@property (nonatomic, strong) NSMutableArray<CBPeripheral *> *peripherals;


#pragma mark -- action method

- (void)onConnectBluetoothWithIndex:(NSInteger)index;

@property (nonatomic, copy) void (^connectionCallBack)(BOOL success);

@end
