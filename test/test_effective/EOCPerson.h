//
//  EOCPerson.h
//  test
//
//  Created by felix on 2017/6/25.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCPerson : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, assign) NSUInteger age;
//如果两个eocperson 的所有字段相等，那么这两个对象就相等，就课可以使用isequal： 这个方法

@end
