//
//  YDFlyWeightViewController.m
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDFlyWeightViewController.h"
#import "FlowerFactory.h"
#import "ExtrinsicFlowerState.h"
#import "FlyweightView.h"

@interface YDFlyWeightViewController ()

@property (nonatomic, strong) FlyweightView *view;

@end

@implementation YDFlyWeightViewController

@dynamic view;

- (void)loadView {
    self.view = [[FlyweightView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test0];
}

- (void)test0 {
    FlowerFactory *factory = [[FlowerFactory alloc] init];
    NSMutableArray *flowerList = [[NSMutableArray alloc] initWithCapacity:500];
    for (int i =0; i < 500; ++i) {
        FlowerType flowerType = arc4random() %kTotalNumberOfFlowerTypes;
        UIView *flowerView = [factory flowerViewWithType:flowerType];

        //         位置
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat x = (arc4random() % (NSInteger)screenRect.size.width);
        CGFloat y = (arc4random() %(NSInteger)screenRect.size.height);
        NSInteger minSize = 10;
        NSInteger maxSize = 50;
        CGFloat size = (arc4random() &(maxSize -minSize +1) + minSize);
        
//         花朵的显示位置和区域
        ExtrinsicFlowerState *extrinsicState = [ExtrinsicFlowerState new];
        extrinsicState.flowerView = flowerView; // 不变的特性
        extrinsicState.area = CGRectMake(x, y, size, size);
        
//        把外面的花朵添加到花朵列表中
        [flowerList addObject:extrinsicState];
    }
    
//     把花朵列表添加到这个FlyweightView 实例中
    [self.view setFlowerList:flowerList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
