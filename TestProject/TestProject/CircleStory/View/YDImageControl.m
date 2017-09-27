//
//  YDImageControl.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDImageControl.h"

@implementation YDImageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.icon == nil) {
            UIImageView *img = [[UIImageView alloc] init];
            [self addSubview:img];
            self.icon = img;
        }
        if (self.statusIcon == nil) {
            UIImageView *img = [[UIImageView alloc] init];
            [self addSubview:img];
            self.statusIcon = img;
        }
        if (self.icon) {
            [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
        [self.statusIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
        }];
        
    }
    return self;
}


@end
