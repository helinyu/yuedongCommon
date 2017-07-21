//
//  PeripheralsModelMgr.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YDPeripheralsModel;
@class YDPeripheralModel;

@interface PeripheralsModelMgr : NSObject

+ (instancetype)shared;

/*
 * @method : shareAndChain
 * @discussion : this method create the obj of self and program for chain
 */
+ (PeripheralsModelMgr* (^)(void))shareAndChain;

/*
 * @method : loadPeripheralModel
 * @discussion : this method for load the model from the local plist file or another
 */
- (PeripheralsModelMgr *(^)(NSString *fileName))loadPeripheralModel;

@property (nonatomic, strong, readonly) YDPeripheralsModel *modelItems;

//@property (nonatomic, copy) void(^peripheralModelItem)(NSString *ServiceUUIDSting);
//- (PeripheralsModelMgr *(^)(NSString *peripheralName))specifyPeripheralCallback;

/*
 * @blcok specifyPeripheralCallback
 * @discussion : with the peripheral name to filter the specify peripheral model 
 */
- (PeripheralsModelMgr *(^)(NSString *peripheralName))specifyPeripheralCallback:(void(^)(YDPeripheralModel *perpheralModel))then;

/*
 * @method: specifyPeripheralWithName
 * @param : name is for using to filter the type which one peripheral's model we want to get
 * @discussion : nil
 */
- (YDPeripheralModel *)specifyPeripheralWithName:(NSString *)name;

@end
