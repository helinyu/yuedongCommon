//
//  PeripheralsModelMgr.m
//  YDBlueTooth
//
//  Created by Aka on 2017/7/21.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "PeripheralsModelMgr.h"
#import "YDPeripheralModel.h"
#import "YYModel.h"

@interface PeripheralsModelMgr ()

@property (nonatomic, strong, readwrite) YDPeripheralsModel *modelItems;

@end

@implementation PeripheralsModelMgr

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

+ (PeripheralsModelMgr* (^)(void))shareAndChain {
    return ^(void) {
        return [PeripheralsModelMgr shared];
    };
}

- (PeripheralsModelMgr *(^)(NSString *fileName))loadPeripheralModel{
    return ^(NSString *fileName){
        NSString *path;
        if (fileName.length <= 0) {
           path = [[NSBundle mainBundle] pathForResource:@"YDBlueBluetooth" ofType:@"plist"];
        }else{
            path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        }
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
        _modelItems = [YDPeripheralsModel yy_modelWithDictionary:dic];
        return self;
    };
}

- (PeripheralsModelMgr *(^)(NSString *peripheralName))specifyPeripheralCallback:(void(^)(YDPeripheralModel *perpheralModel))then {
    __weak typeof (self) wSelf = self;
    return ^(NSString *peripheralName) {
        if (!wSelf.modelItems || wSelf.modelItems.peripherals.count <=0) {
            !then?:then(nil);
            return self;
        }
        
        for (YDPeripheralModel *peripheralModelItem in wSelf.modelItems.peripherals) {
            if ([peripheralModelItem.peripheralName isEqualToString:peripheralName]) {
                !then?:then(peripheralModelItem);
                break;
            }
        }
        return self;
    };
}

- (YDPeripheralModel *)specifyPeripheralWithName:(NSString *)name {
    if (!_modelItems || _modelItems.peripherals.count <=0) {
        return nil;
    }
    
    if (name.length <=0) {
        return _modelItems;
    }
    
    for (YDPeripheralModel *peripheralModelItem in _modelItems.peripherals) {
        if ([peripheralModelItem.peripheralName isEqualToString:name]) {
            return peripheralModelItem;
        }
    }
    
    return nil;
}


@end
