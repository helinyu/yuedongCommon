
//
//  YDZoomView.m
//  test_effective
//
//  Created by Aka on 2017/11/1.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDZoomView.h"
#import "Masonry.h"

@interface YDZoomView ()



@end

@implementation YDZoomView

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    return _zoomView;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    
    _zoomView = [UIScrollView new];
    [self addSubview:_zoomView];
    [_zoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _zoomView.userInteractionEnabled = YES;
    
    _imgBgView = [UIView new];
    [_zoomView addSubview:_imgBgView];
    [_imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_zoomView);
    }];
    _imgBgView.userInteractionEnabled = YES;
    
    _imgView = [UIImageView new];
    [_imgBgView addSubview:_imgView];
    _imgView.userInteractionEnabled = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_imgView.superview);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
    }];
    
    _imgView.userInteractionEnabled = YES;
    _imgView.image = [UIImage imageNamed:@"Snip20171101_1.png"];
}

@end
