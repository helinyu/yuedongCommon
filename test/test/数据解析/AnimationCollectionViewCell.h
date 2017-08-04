//
//  AnimationCollectionViewCell.h
//  test
//
//  Created by Aka on 2017/7/4.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnimationCollectionModel;

@interface AnimationCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, assign) NSInteger type;

- (void)configureAnimationWithIem:(AnimationCollectionModel *)item;

@end

@interface AnimationCollectionModel : NSObject

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *title;

@end
