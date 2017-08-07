//
//  YDDB.h
//  SportsBar
//
//  Created by 张旻可 on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MSMTSDB.h"

//#import "YDDBTable.h"
//#import "YDChatGroupTable.h"
//#import "YDUserInfoTable.h"
//#import "YDRunPointTable.h"

@interface YDDB : MSMTSDB

+ (YDDB *)sharedDb;

@end
