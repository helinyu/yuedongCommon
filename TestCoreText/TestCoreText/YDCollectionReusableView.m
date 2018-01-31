//
//  YDCollectionReusableView.m
//  TestCoreText
//
//  Created by mac on 31/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDCollectionReusableView.h"

@interface YDCollectionReusableView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation YDCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_label) {
            _label = [UILabel new];
            [self addSubview:_label];
            _label.backgroundColor = [UIColor purpleColor];
            _label.text = @"sdfashjd";
        }
    }
    return self;
}

@end
