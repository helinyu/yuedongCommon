//
//  YDPerson.h
//  test_effective
//
//  Created by Aka on 2017/11/9.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *surname;
@property (nonatomic, strong) NSDate *dateOfBirth;

@end
