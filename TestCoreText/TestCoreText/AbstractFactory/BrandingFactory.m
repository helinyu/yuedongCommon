//
//  BrandingFactory.m
//  TestCoreText
//
//  Created by Aka on 2018/3/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BrandingFactory.h"
#import "AcmeBrandingFactory.h"
#import "SierraBrandingFactory.h"

@implementation BrandingFactory

+ (BrandingFactory *)factory {
#if defined (USAE_ACME)
    return [AcmeBrandingFactory new];
#elif defined (USE_SIERRA)
    return [SierraBrandingFactory new];
#else
    return nil;
#endif
}

- (UIView *)brandedView {
    return [UIView new];
}

- (UIButton *)brandedMainButton {
    return [UIButton new];
}

- (UIToolbar *)brandedToolbar {
    return [UIToolbar new];
}

@end
