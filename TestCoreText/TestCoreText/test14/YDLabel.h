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

@property (null_resettable, nonatomic, strong) UIFont *font;

@property (null_resettable, nonatomic, strong) UIColor *textcolor;

@property (nullable, nonatomic, strong) UIColor *shadowColor;

@property(nonatomic)        CGSize             shadowOffset;

@property(nonatomic)        NSTextAlignment    textAlignment;

@property(nonatomic)        NSLineBreakMode    lineBreakMode;

@property (nullable, nonatomic, copy) NSAttributedString *attributeText;

@property (nullable, nonatomic, strong) UIColor *highlightedTextColor;

@property (nonatomic, getter=isHighlighted) BOOL highlighted;

@property (nonatomic, getter=isUserInterfaceEnabled) BOOL userInterfaceEnabled;

@property (nonatomic, getter=isEnabled) BOOL enabled;

@end
NS_ASSUME_NONNULL_END
