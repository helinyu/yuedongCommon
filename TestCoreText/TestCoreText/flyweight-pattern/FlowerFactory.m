//
//  FlowerFactory.m
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FlowerFactory.h"
#import "FlowerView.h"


@interface FlowerFactory ()

@property (nonatomic, strong) NSMutableDictionary *flowerPool;

@end

@implementation FlowerFactory

- (UIView *)flowerViewWithType:(FlowerType)type {
    if (!_flowerPool) {
        _flowerPool = [[NSMutableDictionary alloc] initWithCapacity:kTotalNumberOfFlowerTypes];
    }
    
    UIView *flowerView = [_flowerPool objectForKey:[NSNumber numberWithInt:type]];
    if (!flowerView) {
        UIImage *flowerImage;
        switch (type) {
            case kAnemone:
                flowerImage = [UIImage imageNamed:@"anemone.png"];
                break;
            case kCosmos:
                flowerImage = [UIImage imageNamed:@"cosmos.png"];
                break;
            case kGerberas:
                 flowerImage = [UIImage imageNamed:@"gerberas.png"];
                break;
            case kHollyhock:
                flowerImage = [UIImage imageNamed:@"hollyhock.png"];
                break;
            case kJasmine:
                flowerImage = [UIImage imageNamed:@"jasmine.png"];
                break;
            case kZinnia:
                flowerImage = [UIImage imageNamed:@"zinnia.png"];
                break;
            default:
                break;
        }
        flowerView = [[FlowerView alloc] initWithImage:flowerImage];
        [_flowerPool setObject:flowerView forKey:[NSNumber numberWithInt:type]];
    }
    return flowerView;
}

@end
