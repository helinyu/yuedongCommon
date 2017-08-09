//
//  YDDefine.h
//  BluetoothAttribute
//
//  Created by Aka on 2017/8/8.
//  Copyright © 2017年 Aka. All rights reserved.
//

#ifndef YDDefine_h
#define YDDefine_h

#endif /* YDDefine_h */


#ifndef YDSystemIsGreaterThanOrEqualTo11
    #define YDSystemIsGreaterThanOrEqualTo11 ([UIDevice currentDevice].systemVersion.floatValue >= 11.f)
#endif

typedef NS_ENUM(NSInteger, ConnectionState) {
    ConnectionStateDisconnect = 0,
    ConnectionStateSuccess = 1,
    ConnectionStateFailure = 2,
};
