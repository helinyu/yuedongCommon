//
//  SierraBrandingFactory.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SierraBrandingFactory.h"
#import "SierraView.h"
#import "SierraButton.h"
#import "SierraToolbar.h"



@implementation SierraBrandingFactory

- (UIView *)brandedView {
    SierraView *view = [SierraView new];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}

- (UIButton *)brandedMainButton {
    SierraButton *btn = [SierraButton new];
    btn.backgroundColor = [UIColor redColor];
    return btn;
}

- (UIToolbar *)brandedToolbar {
    SierraToolbar *toolbar = [SierraToolbar new];
    toolbar.backgroundColor = [UIColor purpleColor];
    return toolbar;
}

@end
