//
//  YDUserModel.h
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJsonKit.h"

@interface YDUserModel : NSObject<MSJsonSerializing>

@property (nonatomic,   copy) NSString *avatar;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger lv;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic, strong) NSNumber *followStatus;
@property (nonatomic, strong) NSNumber *userId;
//@property (nonatomic, assign) NSInteger rank;

//honor_title(勋章头衔),talent_title(达人头衔),honor_title_icon_url(勋章图片)
@property (nonatomic,   copy) NSString *honorTitle;
@property (nonatomic,   copy) NSString *talentTitle;
@property (nonatomic,   copy) NSString *honorTitleIconUrl;

@property (nonatomic, assign) BOOL isMemberShip;

@end
