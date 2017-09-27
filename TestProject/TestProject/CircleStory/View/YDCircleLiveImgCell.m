//
//  YDCircleLiveImgCell.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCircleLiveImgCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface YDCircleLiveImgCell ()
@property (nonatomic,   weak) UIImageView *icon;

@end

@implementation YDCircleLiveImgCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.icon == nil) {
            UIImageView *img = [[UIImageView alloc] init];
            [self.contentView addSubview:img];
            self.icon = img;
        }
        if (self.icon) {
            [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
        }
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}
- (void)setImageWith:(NSString *)imageString {
    [self.icon sd_setImageWithURL:[NSURL yd_URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"icon_circle_live_place"]];
}
@end
