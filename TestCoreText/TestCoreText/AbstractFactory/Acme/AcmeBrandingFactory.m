//
//  AcmeBrandingFactory.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AcmeBrandingFactory.h"
#import "AcmeView.h"
#import "AcmeButton.h"
#import "AcmeToolbar.h"

@implementation AcmeBrandingFactory

- (UIView *)brandedView {
    return [AcmeView new];
}

- (UIButton *)brandedMainButton {
    return [AcmeButton new];
}

- (UIToolbar *)brandedToolbar {
    return [AcmeToolbar new];
}

@end
