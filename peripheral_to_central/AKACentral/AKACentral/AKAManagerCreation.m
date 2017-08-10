//
//  AKAManagerCreation.m
//  AKACentral
//
//  Created by Aka on 2017/8/10.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "AKAManagerCreation.h"

@interface AKAManagerCreation ()<NSCacheDelegate>

@property (nonatomic, copy) NSCache *mangerMap;

@end

@implementation AKAManagerCreation

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mangerMap = [NSCache new];
        _mangerMap.delegate = self;
    }
    return self;
}

- (id)mangerWithClass:(Class)class {
    NSObject *obj = _mangerMap[NSStringFromClass(class)];
    if (obj == nil) {
        obj = [class new];
        [_mangerMap setObject:obj forKey:NSStringFromClass(class)];
    }
    return obj;
}

//nschache delegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"cache: %@, evict: %@",cache,obj);
}

@end
