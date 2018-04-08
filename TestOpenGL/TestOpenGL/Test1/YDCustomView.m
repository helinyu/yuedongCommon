//
//  YDCustomView.m
//  TestOpenGL
//
//  Created by Aka on 2018/4/6.
//  Copyright © 2018年 Aka. All rights reserved.
//

#import "YDCustomView.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/EAGL.h>

@implementation YDCustomView

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)[self layer];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithBool:NO],
                              kEAGLDrawablePropertyRetainedBacking,
                              kEAGLColorFormatRGB565,
                              kEAGLDrawablePropertyColorFormat, nil];
        [eaglLayer setOpaque:YES];
        [eaglLayer setDrawableProperties:dict];
    }
    return self;
}

// eaglcontext 和renderBuffer  绑定到layer上面

- (void)drawFrame {
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:context];
    
//    glGenBuffers(1, );
    
}

@end
