//
//  YDImgZoomCCell.m
//  SportsBar
//
//  Created by Aka on 2017/10/30.
//  Copyright © 2017年 yuedong. All rights reserved.
//

#import "YDImgZoomCCell.h"
#import "Masonry.h"

@interface YDImgZoomCCell ()<UIScrollViewDelegate>

@end

static const CGFloat kIndexBtnMarginTop = 33.f;
static const CGFloat kIndexBtnMarginRight = 14.f;
static const CGFloat kIndexBtnLength = 24.f;

@implementation YDImgZoomCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {

    {
        _zoomView = [UIScrollView new];
        [self.contentView addSubview:_zoomView];
        
        _imgBgview = [UIView new];
        [_zoomView addSubview:_imgBgview];
        
        _imgView = [UIImageView new];
        [_imgBgview addSubview:_imgView];
    }
    
    {
        [_zoomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_imgBgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_imgBgview.superview);
        }];
        
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_imgView.superview);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    
    {
        _imgView.image = [UIImage imageNamed:@"Snip20171101_1.png"];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    {
        _zoomView.delegate = self;
        _zoomView.minimumZoomScale = 1.f;
        _zoomView.maximumZoomScale = 3.f;
        _zoomView.bouncesZoom = YES;
        _zoomView.scrollEnabled = YES;
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imgView;
}

@end
