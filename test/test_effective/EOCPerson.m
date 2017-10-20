//
//  EOCPerson.m
//  test
//
//  Created by felix on 2017/6/25.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "EOCPerson.h"

@implementation EOCPerson

// 这个方法可以这样写
- (BOOL)isEqual:(id)object {
    
    if (self == object) return YES;
//    首先判断两个对象的指针是否相等，若是相等，那么指向同一个对象，那个一切都是相等的
    
    if ([self class] != [object class]) {
        return NO;
//        判断两个对象所属的类，若是两个不同的类，那么就是两个不同的对象
//        有的时候，我们可以认为一个实例可以与其子类实例相等
//        在继承体系中判断等同性时，经常遭遇到此类问题，所以在使用equal的时候，需要考虑这种情况
    }
    
    EOCPerson *otherPerson = (EOCPerson *)object;
    if (![_firstName isEqualToString:otherPerson.firstName]) {
        return NO;
    }
    if (![_lastName isEqualToString:otherPerson.lastName]) {
        return NO;
    }
    if (_age != otherPerson.age) {
        return NO;
    }
//    最后检测每个属性是否相等，主要其其中有属性不相等的，就判断两个对象不等，否则是相等的
    return YES;
    
}

//接下来是实现hash的方法
- (NSUInteger)hash {
//    return 1337;
    NSString *stringT0Hash = [NSString stringWithFormat:@"%@:%@:%lu",_firstName,_lastName,(unsigned long)_age];
    return [stringT0Hash hash];
}
// 若是这样写，在collection中使用这种对象将会产生性能问题，因为collection在检索哈希表时候，会用对象的哈希码索引。


@end

//*** 明白等同性的概念和同一对象的区别
//==  判断两个对象是否相等， isequal 这个用于判断是否等同，两个不同的对象可以能是等同性的
//若是两个对象相等，其哈希吗（hash）也是相等的，但是两个哈希码相同的对象未必相等
