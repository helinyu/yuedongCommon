//
//  FlowerFactory.h
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kAnemone,
    kCosmos,
    kGerberas,
    kHollyhock,
    kJasmine,
    kZinnia,
    kTotalNumberOfFlowerTypes,
} FlowerType;

@interface FlowerFactory : NSObject

- (UIView *)flowerViewWithType:(FlowerType)type;


@end
