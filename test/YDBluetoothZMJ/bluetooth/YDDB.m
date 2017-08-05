//
//  YDDB.m
//  SportsBar
//
//  Created by 张旻可 on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "YDDB.h"

#import "YDConstant.h"

#define DEFAULT_ACCOUNT_KEY (123)

static YDDB *sYdDb = nil;

@implementation YDDB

/**
 *  初始化数据库
 *
 *  @param db	数据库对象
 */
-(void)initDb: (FMDatabase *)db {
    [super initDb: db];
//    [YDDBTable createAccountNumTable: db];
//    [YDDBTable createAutoRecordTable: db];
//    [YDDBTable createBraceletDayTable: db];
//    [YDDBTable createBraceletSyncTable: db];
//    [YDDBTable createCalendarStepTable: db];
//    [YDDBTable createPathPointTable: db];
//    [YDDBTable createRunnerTable: db];
//    [YDChatGroupTable createTable: db];
//    [YDUserInfoTable createTable: db];
//    [YDRunPointTable createTable: db];
    
    FMResultSet * rs = [db executeQuery:@"SELECT * FROM AccountNumTable WHERE AccountKey=?",[NSNumber numberWithInt:DEFAULT_ACCOUNT_KEY]];
    if(!rs.next){
        [db executeUpdate:@"INSERT INTO AccountNumTable (AccountKey,SportNum) VALUES (?,?)",[NSNumber numberWithInt:DEFAULT_ACCOUNT_KEY],[NSNumber numberWithInt:-1]];//初始化账户数目为-1，秘钥123
    }
    [rs close];
}

+ (YDDB *)sharedDb {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sYdDb == nil) {
            NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString * path = [arr objectAtIndex:0];
            path = [path stringByAppendingPathComponent: YD_DB_NAME];
            sYdDb = [[YDDB alloc] initWithPath: path identifier: YD_DB_IDENTIFIER];
            [sYdDb open];
        }
    });
    return sYdDb;
}

- (BOOL)upgradeDb:(FMDatabase *)db fromVersion:(NSUInteger)oldVersion toNewVersion:(NSUInteger)newVersion {
    BOOL flag = YES;
    if (oldVersion != 0 && oldVersion < 4) {
        if (![db executeUpdate: @"ALTER TABLE RunnerTable ADD local_status integer"]) {
//            flag = NO;
        }
    }
    if (oldVersion != 0 && oldVersion < 4) {
        if (![db executeUpdate: @"ALTER TABLE yd_run_point ADD distance integer"]) {
//            flag = NO;
        }
    }
    if (oldVersion != 0 && oldVersion < 5) {
        if (![db executeUpdate:@"ALTER TABLE yd_run_point ADD intro text"]) {
//            flag = NO;
        }
    }
    if (oldVersion != 0 && oldVersion < 6) {
        if (![db executeUpdate:@"ALTER TABLE RunnerTable ADD order_id text"]) {
            //            flag = NO;
        }
        if (![db executeUpdate:@"ALTER TABLE RunnerTable ADD order_source text"]) {
            //            flag = NO;
        }
    }
    if (oldVersion != 0 && oldVersion < 7) {
        if (![db executeUpdate:@"ALTER TABLE CalendarStepTable ADD is_other_device integer"]) {
            //            flag = NO;
        }
    }
    return flag;
}

- (NSUInteger)versionCode {
    return 7;
}

@end
