//
//  YDHotTopicModel.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDHotTopicModel.h"
#import "YDUserModel.h"

//static const CGFloat kUserIconTop = 16;
//static const CGFloat kUserIconLeft = 12;
//static const CGFloat kUserIconWH = 32;
//static const CGFloat knickNameLabelTop = 17;
//static const CGFloat knickNameLabelLeft = 8;
//static const CGFloat kLevelLabelTop = 5;
//static const CGFloat kSexIconTop = 2;
//static const CGFloat kSexIconLeft = 9;
//static const CGFloat kSexIconWH = 10;

static const CGFloat kFirstImgLeft = 12;
static const CGFloat kDetailLabelLeft = 12;

@implementation YDHotTopicModel
+ (NSDictionary *)jsonKeyPathsByPropertyKey {
    return @{
             @"action" : @"action",
             @"circle" : @"circle",
             @"commentCount" : @"comment_count",
             @"hotrank" : @"hotrank",
             @"images" : @"images",
             @"text" : @"text",
             @"time" : @"time",
             @"title" : @"title",
             @"topicId" : @"topic_id",
             @"user" : @"user",
             @"viewCount" : @"view_count",
             @"videoTime" : @"video_time",
             @"videoUrlArr" : @"video_url",
             @"likeCnt" : @"like_cnt",
             @"likeFlag" : @"like_flag",
             @"area" : @"area",
             @"param" : @"param",
             };
}

+ (NSDictionary *)keyClass {
    return @{
             };
}

- (CGFloat)getHeight {
    if (self.topicId) {
        if (_height <= 0) {
            if ([self.user.name isEqualToString:@"布衣"]) {
                MSLogI(@"啦啦啦");
            }
            CGFloat height = 0.f;
            CGFloat titleTop = 0.f;
            height += 54;      //userIconTop + userIconHeight
            if (self.title.length) {
                titleTop = 8.f;
                height += titleTop;
                UIFont *font;
                if ([[[UIDevice currentDevice] systemVersion] intValue] < 9) {
                    font = YDF_SYS_B(17.f);
                } else {
                    font = YDF_CUS(YDFontPFangSemibold, 17);
                }
                CGSize size =[self.title sizeWithAttributes:@{NSFontAttributeName:font}];
                height += size.height;
            }
            if (self.text.length) {
                
                height += (titleTop ? 2 : 8);  //detailTop
                
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{NSFontAttributeName:YDF_SYS(15.f), NSForegroundColorAttributeName:YDC_TITLE}];
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                [paragraphStyle setLineSpacing:3];
                [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
                
                CGRect titleSize = [attributedString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH_V0 - 2 * kDetailLabelLeft, 50) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
                if (titleSize.size.height > 50) {
                    height += 50;
                } else {
                    height += titleSize.size.height;
                }
            }
            //imageViewHeight
            CGFloat imgHeight = 0.f;
            CGFloat imgWidth = 0.f;
            CGFloat padding = 0.f;
            CGFloat imgTop = 8.f;
            if (self.param.length) {
                if (self.images.count == 1) {
                    imgWidth = SCREEN_WIDTH_V0 * 205.f / 375;
                    imgTop = 8.f;
                    imgHeight = imgWidth;
                    padding = 0.f;
                } else {
                    imgHeight = 0.f;
                    imgTop = 0.f;
                }
            } else if (self.videoUrlArr.count) {
                if (self.images.count == 1) {
                    imgWidth = SCREEN_WIDTH_V0 - 2 * kFirstImgLeft ;
                    imgTop = 8.f;
                    imgHeight = imgWidth * (150.f/350);
                    padding = 0.f;
                } else {
                    imgHeight = 0.f;
                    imgTop = 0.f;
                }
            } else {
                switch (self.images.count) {
                    case 0:
                        imgHeight = 0.f;
                        imgTop = 0.f;
                        break;
                    case 1:
                        imgWidth = DEVICE_WIDTH_OF(230.f);
                        imgHeight = imgWidth;
                        imgTop = 8.f;
                        padding = 0.f;
                        break;
                    case 2:
                        imgTop = 8.f;
                        padding = 8.f;
                        imgWidth = (CGFloat)(SCREEN_WIDTH_V0 - 2 * kFirstImgLeft - padding)/2;
                        imgHeight = imgWidth * (126.f/175);
                        break;
                    case 3:
                        imgTop = 8.f;
                        padding = 2.f;
                        imgWidth = (CGFloat)(SCREEN_WIDTH_V0 - 2 * kFirstImgLeft - 2 * padding)/3;
                        imgHeight = imgWidth;
                        break;
                    default:
                        break;
                }
            }
            height += (imgHeight + imgTop);
            //位置信息
            if (self.area.length) {
                height += 8.f; //areaTop
                CGSize size =[self.area sizeWithAttributes:@{NSFontAttributeName:YDF_SYS(13)}];
                height += size.height;
            }
            height += 14.f;  //typeIconTop
            height += 20.f;  //typeIconHeight
            height += 14.f;  //typeIconBottom
            _height = height;
        }
    }
    return _height;
}


@end
