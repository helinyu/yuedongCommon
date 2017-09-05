//
//  YDSongEnty.m
//  _YDBridgeWebViewController
//
//  Created by Aka on 2017/8/21.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDMedia.h"
#import "YYModel.h"

@implementation YDMedia

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (YDMedia *)mediaConvertionWithDic:(NSDictionary *)dic{
    YDMedia *media = [YDMedia yy_modelWithDictionary:dic];
    return media;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"mediaItemList" : [YDMediaItem class]};
}

@end


@implementation YDMediaItem

@end
