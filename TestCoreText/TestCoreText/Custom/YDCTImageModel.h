//
//  YDCTImageModel.h
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YDCTImageModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger postion;

@property (nonatomic) CGRect imagePosition;
// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系 (注意)

@end
