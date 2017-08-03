//
//  LYBlockPerson2.h
//  test
//
//  Created by Aka on 2017/7/19.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYBlockPerson2 : NSObject

//block 本来就是一个指针，所以是可以使用 "." 来进行调用的，应为返回值是一个block的类型，并且block中的返回值是当前对象的实例，所以，就可以实现了链式调用

- (LYBlockPerson2 * (^)(NSString *name))study;
- (LYBlockPerson2 * (^)(void))run;

@end
