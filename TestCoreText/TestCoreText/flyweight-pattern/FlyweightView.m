//
//  FlyweightView.m
//  Flyweight
//
//  Created by Carlo Chung on 11/29/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "FlyweightView.h"
#import "ExtrinsicFlowerState.h"

@implementation FlyweightView

@synthesize flowerList=flowerList_;

extern NSString *FlowerObjectKey, *FlowerLocationKey;


- (void)drawRect:(CGRect)rect 
{
  for (ExtrinsicFlowerState *stateValue in flowerList_)
  {
    UIView *flowerView = stateValue.flowerView;
    CGRect area = stateValue.area;
    [flowerView drawRect:area];
  }
}

- (void)dealloc 
{
}


@end
