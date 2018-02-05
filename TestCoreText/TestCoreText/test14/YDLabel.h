//
//  YDLabel.h
//  TestCoreText
//
//  Created by mac on 5/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface YDLabel : UIView<NSCoding>

@property (nullable, nonatomic, copy) NSString *text;

@property (nullable, nonatomic, copy) NSAttributedString *attributeText;

@end
NS_ASSUME_NONNULL_END
