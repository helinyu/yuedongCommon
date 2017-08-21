//
//  TestSpriteViewController.m
//  YY
//
//  Created by Aka on 2017/8/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "TestSpriteViewController.h"
#import "YYimage.h"

@interface TestSpriteViewController ()

@end

@implementation TestSpriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"ResourceTwitter.bundle/fav02l-sheet@2x.png"];
    UIImage *sheet = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:path] scale:2];
    NSMutableArray *contentRects = [NSMutableArray new];
    NSMutableArray *durations = [NSMutableArray new];
    
    
    // 8 * 12 sprites in a single sheet image
    CGSize size = CGSizeMake(sheet.size.width / 8, sheet.size.height / 12);
    for (int j = 0; j < 12; j++) {
        for (int i = 0; i < 8; i++) {
            CGRect rect;
            rect.size = size;
            rect.origin.x = sheet.size.width / 8 * i;
            rect.origin.y = sheet.size.height / 12 * j;
            [contentRects addObject:[NSValue valueWithCGRect:rect]];
            [durations addObject:@(1 / 60.0)];
        }
    }
    YYSpriteSheetImage *sprite;
    sprite = [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:sheet
                                                     contentRects:contentRects
                                                   frameDurations:durations
                                                        loopCount:0];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:sprite];
    
    imageView.frame = CGRectMake(30, 70, 50, 50);
    
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
