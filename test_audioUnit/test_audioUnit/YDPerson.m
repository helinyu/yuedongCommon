//
//  YDPerson.m
//  test_audioUnit
//
//  Created by Aka on 2018/5/16.
//  Copyright © 2018年 Aka. All rights reserved.
//

#import "YDPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation YDPerson

- (void)sentd {
    ((void (*)(id, SEL, NSString *))(void *) objc_msgSend)(self, @selector(onlog:),@"name");
}

- (void)onlog:(NSString *)name {
    NSLog(@"name : %@",name);
}

@end
