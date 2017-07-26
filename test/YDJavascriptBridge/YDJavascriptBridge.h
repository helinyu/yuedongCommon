//
//  YDJavascriptBridge.h
//  YDJavascriptBridge
//
//  Created by Aka on 2017/7/26.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIWebView;

@interface YDJavascriptBridge : NSObject

+ (instancetype)bridgeWithUIWebview:(UIWebView *)webView;

- (void)evaluateScript:(NSString *)script;

typedef void (^ResponseComplete)(NSDictionary *responseDic);

//recommeded
- (void)registerMethod:(NSString *)methodString complete:(ResponseComplete)complete;

// not recommed
- (void)registerMethodNoDatasCallback:(NSString *)methodString complete:(void(^)(void))complete;

@end
