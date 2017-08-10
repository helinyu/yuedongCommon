//
//  AKAManagerCreation.h
//  AKACentral
//
//  Created by Aka on 2017/8/10.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CreateMgr(classname) ((classname *)[[AKAManagerCreation shared] mangerWithClass:classname.class])

@interface AKAManagerCreation : NSObject

+ (instancetype)shared;
- (id)mangerWithClass:(Class)class;

@end

#import "AKAPeirpheralManger.h"
