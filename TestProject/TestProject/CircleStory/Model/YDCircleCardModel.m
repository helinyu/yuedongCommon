//
//  YDCircleRootModel.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCircleCardModel.h"

@implementation YDCircleCardModel

- (CGSize)getItemSize {
    CGFloat width = 0.f;
    CGFloat height = 0.f;
    switch (self.type) {
        case YDCircleCardModelTypeCircle:
        {
            width = floor(SCREEN_WIDTH_V0 / 4);
            height = 98.f;
        }
            break;
        case YDCircleCardModelTypeLive:
        {
            width = (SCREEN_WIDTH_V0 - 2 * 12 - 4 * 8) / 5;
            height = width;
        }
            break;
        case YDCircleCardModelTypeActivity:
        {
            width = (SCREEN_WIDTH_V0 - 3 * 12) / 2;
            height = width * 88.f / 170.f;
        }
            break;
        case YDCircleCardModelTypeChoiceness:
        {
            width = SCREEN_WIDTH_V0 / 3;
            height = 78.f;
        }
            break;
        case YDCircleCardModelTypeTopic:
        {
            width = SCREEN_WIDTH_V0;
            height = self.topicModel.height ? self.topicModel.height : 0.f;
        }
            break;
        case YDCircleCardModelTypeRecommend:
        {
            width = SCREEN_WIDTH_V0;
            height = self.recommendInfos.count ? (DEVICE_WIDTH_OF(148.f) * 192.f / 148.f + 14 + 40 + 15 + 18) : 0.f;
        }
            break;
        case YDCircleCardModelTypeAd:
        {
            width = SCREEN_WIDTH_V0;
            height = self.ad.circleCellHeight ? self.ad.circleCellHeight : 0.f;
        }
            break;
        default:
            break;
    }
    _itemSize = CGSizeMake(width, height);
    return _itemSize;
}

@end
