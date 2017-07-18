//
//  YDBlueToothMgr.h
//  test
//
//  Created by Aka on 2017/7/18.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBPeripheral;
@class CBService;

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
 * @param :blue tooth search & filter key word and  pattern, required
 * @discussion: this filed must field one and configure with the filterType
 */
@property (nonatomic, copy) NSString *matchField;
@property (nonatomic, copy) NSString *prefixField;
@property (nonatomic, copy) NSString *suffixField;
@property (nonatomic, copy) NSString *containField;

/*
 * param : filterType required
 * discussion : filter determine which type we will use to filter and find the specify bluetooth
 */
@property (nonatomic, assign) YDBlueToothFilterType filterType;


#pragma mark -- action method
//scan
@property (nonatomic, copy) void(^scanCallBack)(NSArray<CBPeripheral *> *peripherals);

@property (nonatomic, copy) void(^servicesCallBack)(NSArray<CBService *> *services);

//connect
- (void)onConnectBluetoothWithIndex:(NSInteger)index;

@property (nonatomic, copy) void (^connectionCallBack)(BOOL success);

@end
