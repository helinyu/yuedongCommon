//
//  YDHeaderView.m
//  TestCoreText
//
//  Created by mac on 25/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDHeaderView.h"
#import <DTCoreText.h>
#import "Masonry.h"

@interface YDHeaderView ()

//@property (nonatomic, strong) DTAttributedLabel *label;
@property (nonatomic, strong) DTAttributedTextView *textView;


@end

@implementation YDHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self baseInit];
//    }
//    return self;
//}

- (void)baseInit {
    self.backgroundColor = [UIColor redColor];
    _label = [DTAttributedLabel new];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _label.backgroundColor = [UIColor blueColor];
}

@end
