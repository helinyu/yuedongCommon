//
//  Person.h
//  ivar
//
//  Created by Aka on 2017/8/19.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>


//@property = Ivar + setter + getter
//Ivar可以理解为类中的一个变量，主要作用是用来保存数据的。

@interface Person : NSObject
{
    NSString *_name0;
}
@property (nonatomic, copy) NSString *name1;
// _name0 是变量，name1 是属性

//test the readonly & variable
@property (nonatomic, copy, readonly) NSString *name3;

- (void)test0;
- (void)test1;

@end
